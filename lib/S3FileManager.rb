# frozen_string_literal: true

require_relative "S3FileManager/version"

module S3FileManager
  class Error < StandardError; end

  class S3FileManager
    DEFAULT_S3_CONFIG_OPTS = {
      access_key_id:     ENV['S3_ACCESS_KEY_ID'],
      secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
      region:            ENV['AWS_REGION']
    }

    def initialize(bucket_name, folder, file_name)
      @folder      = folder
      @file_name   = file_name
      @bucket_name = bucket_name
      @s3_client   = Aws::S3::Client.new(s3_config_opts)
    end

    def self.read_file(bucket_name:, folder: nil, file_name:)
      new(bucket_name, folder, file_name).read_file
    end

    def read_file
      begin
        @file = get_file.body.read
      rescue => e
        errors << e
      end

      result
    end

    def result
      OpenStruct.new(
        success?: valid?,
        errors: errors,
        file: file
      )
    end

    private

    attr_reader :folder, :file_name, :s3_client, :bucket_name, :file

    def get_file
      s3_client.get_object(bucket: bucket_name, key: key)
    end

    def key
      return file_name unless folder

      "#{folder}/#{file_name}"
    end

    def s3_config_opts
      opts = DEFAULT_S3_CONFIG_OPTS

      opts.merge!(
        endpoint: ENV.fetch('MINIO_ENDPOINT', 'http://minio:9000'),
        force_path_style: true
      ) if Rails.env.development?

      opts
    end

    def errors
      @errors ||= []
    end

    def valid?
      errors.blank?
    end
  end
end

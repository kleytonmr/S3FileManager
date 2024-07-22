# frozen_string_literal: true

require_relative "s3_file_manager"

module S3FileManager
  class Error < StandardError; end

  class Handler
    def initialize(bucket_name, folder, file_name)
      @folder      = folder
      @file_name   = file_name
      @bucket_name = bucket_name
      @s3_client   = S3FileManager::S3Client.instance.client
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

    def errors
      @errors ||= []
    end

    def valid?
      errors.empty?
    end
  end
end

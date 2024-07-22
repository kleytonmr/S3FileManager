# frozen_string_literal: true

require "singleton"

module S3FileManager
  class S3Client
    include Singleton

    DEFAULT_S3_CONFIG_OPTS = {
      region:            ENV["AWS_REGION"],
      access_key_id:     ENV["S3_ACCESS_KEY_ID"],
      secret_access_key: ENV["S3_SECRET_ACCESS_KEY"]
    }.freeze

    def initialize
      @client = Aws::S3::Client.new(s3_config_opts)
    end

    def client
      @client
    end

    private

    def s3_config_opts
      opts = DEFAULT_S3_CONFIG_OPTS

      if defined?(Rails) && Rails.env.development?
        opts.merge!(
          endpoint: ENV.fetch("MINIO_ENDPOINT", "http://minio:9000"),
          force_path_style: true
        )
      end

      opts
    end
  end
end

# frozen_string_literal: true

require_relative "s3_file_manager"

module S3FileManager
  class Error < StandardError; end

  class Handler
    def initialize
      @s3_client = S3FileManager::S3Client.instance.client
    end

    def self.read_file(bucket_name:, folder: nil, file_name:)
      new.read_file(bucket_name, folder, file_name)
    end

    def read_file(bucket_name, folder, file_name)
      S3FileManager::ReadFile.new(
        s3_client, bucket_name, folder, file_name
      ).execute
    end

    private

    attr_reader :s3_client
  end
end

# frozen_string_literal: true

require_relative "S3FileManager/version"
require "S3FileManager/base"
require "S3FileManager/read_file"
require "aws-sdk-s3"
require "ostruct"
require "dotenv"

Dotenv.load

module S3FileManager
  autoload :S3Client, "S3FileManager/s3_client"
end

module S3FileManager
  class Base
    def initialize(client, bucket_name, folder, file_name)
      @client      = client
      @folder      = folder
      @file_name   = file_name
      @bucket_name = bucket_name
    end

    private

    attr_reader :folder, :file_name, :bucket_name, :client

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

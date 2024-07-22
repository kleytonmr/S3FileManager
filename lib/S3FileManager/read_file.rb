module S3FileManager
  class ReadFile < Base
    def execute
      begin
        @file = get_file.body.read
      rescue => e
        errors << e.message
      end

      result
    end

    private

    attr_reader :file

    def get_file
      client.get_object(bucket: bucket_name, key: key)
    end

    def result
      OpenStruct.new(
        success?: valid?,
        errors: errors,
        file: file
      )
    end
  end
end

require 'aws-sdk'
require 'digest'
module Menu
  class Release < OpenStruct
    def <=> o
      version <=> o.version
    end

    def upload_payload options
      unless File.exists? @payload_file
        puts "Could not open payload"
        exit 1
      end
      s3 = Aws::S3::Client.new(region: 'us-east-1')
      key = "#{options.component}/v#{self.version}-#{checksum}#{File.extname(@payload_file)}"
      puts "Uploading payload (#{key}) to S3..." if options.verbose
      s3.put_object(
        acl: "public-read",
        body: File.open(@payload_file),
        bucket: options.bucket,
        key: key
      )
      puts "Upload complete." if options.verbose
      self.payload = ENV['MENU_SSL_URL'] + '/' + key
    end

    def payload_file= file
      @payload_file = file
      @checksum = Digest::MD5.file(file).hexdigest
    end

    def checksum
      raise "No payload" unless @checksum
      @checksum
    end

    def to_json s
      {
        version: version,
        beta: beta,
        payload: payload,
        md5: checksum
      }.to_json
    end
  end
end

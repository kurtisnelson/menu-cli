require 'aws-sdk'
require 'digest'
module Menu
  class Release < OpenStruct
    attr_accessor :options

    def <=> o
      version <=> o.version
    end

    def upload_payload
      s3 = Aws::S3::Client.new(region: 'us-east-1')
      key = "#{options.component}/v#{self.version}-#{@md5}#{File.extname(@payload_file)}"
      puts "Uploading payload (#{key}) to S3..." if @options.verbose
      s3.put_object(
        acl: "public-read",
        body: File.open(@payload_file),
        bucket: @options.bucket,
        key: key
      )
      puts "Upload complete." if @options.verbose
      self.payload = ENV['MENU_SSL_URL'] + '/' + key
    end

    def payload_file= file
      unless File.exists? file
        puts "Could not open payload"
        exit 1
      end
      @payload_file = file
      puts "Calcuating checksum..." if @options.verbose
      md5 = Digest::MD5.file(file).hexdigest
      @md5 = md5
      puts "Checksum: "+ md5
    end

    def to_json s
      {
        version: version,
        beta: beta,
        payload: payload,
        md5: md5
      }.to_json
    end
  end
end

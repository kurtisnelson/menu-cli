require 'aws-sdk'
require 'digest'
module Menu
  class Release
    attr_accessor :options
    attr_accessor :version, :md5, :payload, :beta

    def initialize hash={}
      @version = hash['version']
      @md5 = hash['md5']
      @payload = hash['payload']
      @beta = hash['beta']
    end

    def <=> o
      version <=> o.version
    end

    def upload_payload
      s3 = Aws::S3::Client.new(region: 'us-east-1')
      key = "#{options.component}/v#{@version}-#{@md5}#{File.extname(@payload_file)}"
      puts "Uploading payload (#{key}) to S3..." if @options.verbose
      s3.put_object(
        acl: "public-read",
        body: File.open(@payload_file),
        bucket: @options.bucket,
        key: key
      )
      puts "Upload complete." if @options.verbose
      @payload = ENV['MENU_SSL_URL'] + '/' + key
    end

    def payload_file= file
      unless File.exists? file
        puts "Could not open payload"
        exit 1
      end
      @payload_file = file
      puts "Calcuating checksum..." if @options.verbose
      @md5 = Digest::MD5.file(file).hexdigest
      puts "Checksum: "+ @md5
    end

    def to_json s
      {
        version: @version,
        beta: @beta,
        payload: @payload,
        md5: @md5
      }.to_json
    end
  end
end

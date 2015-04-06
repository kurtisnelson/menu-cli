require 'aws-sdk'
module Menu
  class Release < OpenStruct
    def <=> o
      version <=> o.version
    end

    def upload_payload options
      unless File.exists? payload_file
        puts "Could not open payload"
        exit 1
      end
      s3 = Aws::S3::Client.new(region: 'us-east-1')
      key = "#{options.component}/v#{self.version}#{File.extname(payload_file)}"
      puts "Uploading payload (#{key}) to S3..." if options.verbose
      s3.put_object(
        acl: "public-read",
        body: File.open(payload_file),
        bucket: 'machine-software',
        key: key
      )
      puts "Upload complete." if options.verbose
      self.payload = "https://updates.monsieur.co/" + key
    end

    def to_json s
      {
        beta: beta,
        version: version,
        payload: payload
      }.to_json
    end
  end
end

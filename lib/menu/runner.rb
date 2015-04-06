module Menu
  class Runner
    def initialize options
      @options = options
    end

    def release
      releases = Menu::Releases.do @options.component
      version = next_version(releases)

      if @options.release && @options.release < version
        puts "Version number already exists, are you sure you want to overwrite? [y/N]"
        exit 1 unless gets.chomp == 'y'
      end
      version = @options.release if @options.release
      releases.delete_if {|r| r.version == version }

      log "Release ##{version} for #{@options.component}..."
      log "Beta release" if @options.beta

      r = Release.new
      r.options = @options
      r.version = version
      r.payload_file = @options.payload
      r.beta = @options.beta
      r.upload_payload

      releases << r

      s3 = Aws::S3::Client.new(region: 'us-east-1')
      log "Uploading JSON..."
      log releases.to_json
      s3.put_object(
        acl: "public-read",
        body: releases.to_json,
        bucket: @options.bucket,
        key: "#{@options.component}.json",
        content_type: "application/json",
        cache_control: "public, s-maxage=7200, max-age=120"
      )
      log "JSON uploaded"
    end

    def next_version releases
      version = 0
      releases.each do |r|
        version = r.version if r.version > version
      end
      version += 1
      version
    end

    def log str
      puts str if @options.verbose
    end
  
  end
end

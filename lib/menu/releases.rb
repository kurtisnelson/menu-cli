require 'faraday'
require 'faraday_middleware'
module Menu
  class Releases < Array
    def self.do component
      raise "Missing component" unless component
      response = @@con.get("/#{component}.json")
      if response.success?
        Releases.from_array response.body['releases']
      else
        puts "New component, creating empty list"
        Releases.new
      end
    end

    def self.from_array arr
      r = Releases.new
      arr.each {|i| r << Release.new(i)}
      r
    end

    def to_json
      {
        releases: sort_by {|o| o.version}
      }.to_json
    end

    @@con = Faraday.new(:url => ENV['MENU_URL']) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :json, :content_type => /\bjson$/
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end
end

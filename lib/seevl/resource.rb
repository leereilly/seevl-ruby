require 'uri'
require 'net/http'
require 'json'

module Seevl

  class Resource

    @@base = ENV['SEEVL_BASE'] || 'http://seevl.net'
    @@id   = ENV['SEEVL_ID']
    @@key  = ENV['SEEVL_KEY']

    # To be overridden
    @@mapping = {}

    def initialize(uri)
      if !@@id || !@@key
        raise 'Please set the SEEVL_ID and SEEVL_KEY environment variables'
      end
      @uri = uri
    end

    def Resource.find_by_id(id)
      self.new @@base + "/entity/#{id}"
    end

    def Resource.base=(base)
      @@base = base
    end

    def Resource.mapping=(mapping)
      @@mapping = mapping
    end

    def properties
      @@mapping.keys
    end

    def uri
      @uri
    end

    def method_missing(m, *args, &block)
      if @@mapping.keys.member? m
        load_partial_data(@@mapping[m])
      end
      send m if self.class.method_defined? m
    end

    protected

    def load_partial_data(partial)
      uri = @uri + '/' + partial
      data = JSON.parse(http_get(uri))
      data[partial].keys.each do |key|
        if data[partial][key].size == 1
          value = data[partial][key][0]['value']
        else
          value = []
          data[partial][key].each do |v|
            value << v['value']
          end
        end
        self.class.send(:define_method, key) { return value }
      end
    end

    def http_get(uri)
      u = URI.parse(uri)
      req = Net::HTTP::Get.new(u.path, { 'Accept' => 'application/json', 'X-APP_ID' => @@id, 'X-APP_KEY' => @@key })
      res = Net::HTTP.new(u.host, u.port).start { |http| http.request(req) }
      case res
      when Net::HTTPSuccess
        res.body
      else
        res.error!
      end
    end

  end

end

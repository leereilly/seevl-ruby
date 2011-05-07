module Seevl
  # Mocking http requests
  class Resource
    protected
    def Resource.http_get(uri)
      case uri
      when 'http://seevl.net/entity/foo/infos'
        '{"infos":{"name":[{"value":"bar"}]}}'
      when 'http://seevl.net/entity/foo/facts'
        '{"facts":{"origin":[{"value":"Paris"},{"value":"London"}]}}'
      when 'http://seevl.net/entity/?name=bad&type=artist'
        '{"results":[{"sid":"s1","name":"bad religion"},{"sid":"s2","name":"bad brains"}]}'
      end
    end
  end
end

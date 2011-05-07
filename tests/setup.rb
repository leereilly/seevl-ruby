module Seevl
  # Mocking http requests
  class Resource
    protected
    def Resource.http_get(uri)
      case uri
      when 'http://seevl.net/entity/foo/infos'
        '{"name":[{"value":"bar"}]}'
      when 'http://seevl.net/entity/foo/facts'
        '{"origin":[{"value":"Paris"},{"value":"London"}]}'
      when 'http://seevl.net/entity/?name=bad&type=artist'
        '{"results":[{"sid":"s1","name":"bad religion"},{"sid":"s2","name":"bad brains"}]}'
      when 'http://seevl.net/entity/foo/related'
        '{"related":[{"sid":"s1","name":"descendents"},{"sid":"s2","name":"all"}]}'
      end
    end
  end
end

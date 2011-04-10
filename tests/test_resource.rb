require "rubygems"
require "test/unit"

require File.expand_path(File.dirname(__FILE__)) + '/../lib/seevl/resource'

module Seevl

  class TestResource < Test::Unit::TestCase

    Resource.base = 'http://seevl.net'

    def test_initialize
      obj = Resource.new 'http://example.com'
      assert_equal 'http://example.com', obj.uri
    end

    def test_find_by_id
      obj = Resource.find_by_id 'foo'
      assert_equal 'http://seevl.net/entity/foo', obj.uri
    end

    def test_method_missing
      obj = Resource.find_by_id 'foo'
      # method name doesn't exist in mapping
      assert_equal nil, obj.blah
      # method name exists in mapping, single result
      Resource.mapping = { :name => 'infos' }
      assert_equal 'bar', obj.name
      # method name exists in mapping, multiple results
      Resource.mapping = { :origin => 'facts' }
      assert_equal ["Paris", "London"], obj.origin
      # name and origin aren't in the mapping anymore, but results are cached
      Resource.mapping = {}
      assert_equal 'bar', obj.name
      assert_equal ["Paris", "London"], obj.origin
      # in mapping, but not in response
      Resource.mapping = { :description => 'infos' }
      assert_equal nil, obj.description
    end

  end

  # Monkey-patching Seevl::Resource
  class Resource
    protected
    def http_get(uri)
      case uri
      when 'http://seevl.net/entity/foo/infos'
        '{"infos":{"name":[{"value":"bar"}]}}'
      when 'http://seevl.net/entity/foo/facts'
        '{"facts":{"origin":[{"value":"Paris"},{"value":"London"}]}}'
      end
    end
  end

end

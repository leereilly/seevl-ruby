require "rubygems"
require "test/unit"

require File.expand_path(File.dirname(__FILE__)) + '/../lib/seevl/resource'
require File.expand_path(File.dirname(__FILE__)) + '/../lib/seevl/artist'
require File.expand_path(File.dirname(__FILE__)) + '/setup'

module Seevl
  class TestArtist < Test::Unit::TestCase

    Resource.base = 'http://seevl.net'

    def test_find_all_by_name
      artists = Artist.find_all_by_name('bad')
      assert_equal 2, artists.size
      assert_equal 's1', artists[0].sid
      assert_equal 'bad religion', artists[0].name
      assert_equal 's2', artists[1].sid
      assert_equal 'bad brains', artists[1].name
    end

    def test_related
      artist = Artist.find_by_id('foo')
      related = artist.related
      assert_equal 2, related.size
      assert_equal 's1', related[0].sid
      assert_equal 'descendents', related[0].name
      assert_equal 's2', related[1].sid
      assert_equal 'all', related[1].name
    end

  end
end

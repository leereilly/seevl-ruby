require File.expand_path(File.dirname(__FILE__)) + '/resource'

module Seevl

  class Artist < Resource

    @@mapping = {
      :name        => 'infos',
      :description => 'infos',
      :origin      => 'facts',
      :genre       => 'facts',
      :location    => 'facts',
      :member      => 'facts',
      :label       => 'facts',
      :topic       => 'topics',
      :homepage    => 'links',
      :wikipedia   => 'links',
      :musicbrainz => 'links',
      :nytimes     => 'links',
      :freebase    => 'links',
    }

    def Artist.find_all_by_name(name)
      uri = @@base + "/entity/?name=#{URI.escape(name)}&type=artist"
      data = JSON.parse(self.http_get(uri))
      artists = []
      data['results'].each do |artist_data|
        artists << Artist.new(@@base + "/entity/#{artist_data['sid']}", artist_data)
      end
      return artists
    end

    def related
      uri = @uri + '/related'
      data = JSON.parse(self.class.http_get(uri))
      related = []
      data['related'].each do |artist_data|
        related << Artist.new(@@base + "/entity/#{artist_data['sid']}", artist_data)
      end
      return related
    end

  end

end

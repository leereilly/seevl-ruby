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

  end

end

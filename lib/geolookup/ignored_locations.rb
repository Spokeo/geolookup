require 'yaml'

module Geolookup

  module IgnoredLocations
    IGNORED_LOCATIONS_FILE = "IGNORED_LOCATIONS.yml"

    @ignored_locations

    def self.ignored_locations
      @ignored_locations ||= Geolookup.load_hash_from_file(IGNORED_LOCATIONS_FILE)
      @ignored_locations
    end

  end
end

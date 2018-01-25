module Geolookup
  module USA
    module City

      CITY_MAP = 'CITIES.yml'

      @cities_by_name

      def self.find_cities_by_name(city_name)
        @cities_by_name ||= Geolookup.load_hash_from_file(CITY_MAP)

        @cities_by_name[city_name.downcase] || []
      end

    end
  end
end
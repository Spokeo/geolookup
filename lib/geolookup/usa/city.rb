module Geolookup
  module USA
    module City

      CITY_MAP = 'CITIES.yml'
      ZIP_CITY = 'ZIP_CITY.yml'


      @cities_by_name

      def self.find_cities_by_name(city_name)
        @cities_by_name ||= Geolookup.load_hash_from_file(CITY_MAP)

        @cities_by_name[city_name.to_s.downcase] || []
      end

      def self.find_city_by_zip(zip)
        @zip_city_map ||= Geolookup.load_hash_from_file(ZIP_CITY)

        @zip_city_map[zip.to_s]
      end

    end
  end
end

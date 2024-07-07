module Geolookup
  module USA
    module Zipcodes
      # In the future if zip information is updated in mysql, the yml can be recreated via the following
      # zip_lat_long_data = {}
      # ZipCityGeolocationMapping.find_each {|zip| zip_lat_long_data[zip.zip] = {lat_int: zip.lat_int, long_int: zip.long_int}}
      # File.open('ZIP_LAT_LONG.yml', "w") {|file| file.puts zip_lat_long_data.to_yaml}

      ZIP_LAT_LONG_FILE = 'ZIP_LAT_LONG.yml'
      ZIP_TO_CITY_STATE_FILE = 'ZIP_TO_CITY_STATE.yml'

      def self.lat_long(zipcode)
        @zip_lat_long_hash ||= Geolookup.load_hash_from_file(ZIP_LAT_LONG_FILE)
        @zip_lat_long_hash[zipcode.to_i] || {}
      end

      # Return array [city, state_abbr]
      def self.city_state(zipcode)
        @zip_to_city_state_hash ||= Geolookup.load_hash_from_file(ZIP_TO_CITY_STATE_FILE)
        info = @zip_to_city_state_hash[zipcode]
        info ? info.split(',').reverse : nil
      end
    end
  end
end

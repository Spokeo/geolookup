# encoding: UTF-8
#################################################################
# Geocode::TigerLine::Fips
#
# This module contains all the state and country lat longs,
# display names too
#
module Geolookup

  module Country
    @country_yml  = YAML.load_file("country.yml")
    @NAME_TO_CODE = @country_yml['NAME_TO_CODE']
    @CODE_TO_NAME = @country_yml['CODE_TO_NAME']
    @LAT_LONG     = @country_yml['LAT_LONG']

    def self.name_to_code(country_name)
      @NAME_TO_CODE[country_name.to_s.upcase]
    end

    def self.code_to_name(country_code)
      @CODE_TO_NAME[country_code.to_s.upcase]
    end

    #def self.code_to_lat_long(country_code)
    #  LAT_LONG[country_code.to_s.upcase]
    #end

    def self.name_to_lat_long(country_name)
      @LAT_LONG[country_name.to_s.upcase]
    end
  end
end
# encoding: UTF-8
#################################################################
# Geocode::TigerLine::Fips
#
# This module contains all the state and country lat longs,
# display names too
#
require 'yaml'

module Geolookup

  module Country
    COUNTRY_NAME_TO_CODE_FILE = "./lib/data/COUNTRY_NAME_TO_CODE.yml"
    COUNTRY_CODE_TO_NAME_FILE = "./lib/data/COUNTRY_CODE_TO_NAME.yml"
    COUNTRY_LAT_LONG_FILE     = "./lib/data/COUNTRY_LAT_LONG.yml"

    @country_name_to_code
    @country_code_to_name
    @country_lat_long
    
    def self.name_to_code(country_name)
      if !@country_name_to_code
        @country_name_to_code = Geolookup.load_hash_from_file(COUNTRY_NAME_TO_CODE_FILE)
      end      
      @country_name_to_code[country_name.to_s.upcase]
    end

    def self.code_to_name(country_code)
      if !@country_code_to_name
        @country_code_to_name = Geolookup.load_hash_from_file(COUNTRY_CODE_TO_NAME_FILE)
      end
      @country_code_to_name[country_code.to_s.upcase]
    end

    #def self.code_to_lat_long(country_code)
    #  LAT_LONG[country_code.to_s.upcase]
    #end

    def self.name_to_lat_long(country_name)
      if !@country_lat_long
        @country_lat_long = Geolookup.load_hash_from_file(COUNTRY_LAT_LONG_FILE)
      end
      @country_lat_long[country_name.to_s.upcase]
    end
  end
end

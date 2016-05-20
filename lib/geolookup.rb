require 'geolookup/version'
require 'geolookup/usa/county'
require 'geolookup/usa/state'
require 'geolookup/usa/metro'
require 'geolookup/country'
require 'geolookup/country_phone_codes'
require 'geolookup/usa/areacodes'
require 'geolookup/usa/zipcodes'

module Geolookup
  ###################################################################
  # self.load_file
  #
  # Loads a given .yml file that contains a hash and returns the hash
  #
  def self.load_hash_from_file(file_name)
    YAML.load_file(File.join(File.dirname(__FILE__), "data/", file_name))
  end
end

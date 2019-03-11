require 'csv'
require 'geolookup/version'
require 'geolookup/usa/county'
require 'geolookup/usa/state'
require 'geolookup/usa/metro'
require 'geolookup/country'
require 'geolookup/country_phone_codes'
require 'geolookup/usa/areacodes'
require 'geolookup/usa/zipcodes'
require 'geolookup/region'
require 'geolookup/ignored_locations'
require 'geolookup/usa/city'

module Geolookup
  ###################################################################
  # self.load_file
  #
  # Loads a given .yml file that contains a hash and returns the hash
  #
  def self.load_hash_from_file(file_name)
    YAML.load_file(File.join(File.dirname(__FILE__), 'data/', file_name))
  end

  def self.load_list_from_csv(fname, col_sep: ',')
    CSV.read(File.join(File.dirname(__FILE__), 'data/', fname), col_sep: col_sep)
  end

end

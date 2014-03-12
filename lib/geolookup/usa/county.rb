# encoding: UTF-8
module Geolookup
  module USA
    module County
      @county_yml           = YAML.load_file("county.yml")
      @CODE_TO_COUNTY_NAME  = @county_yml['CODE_TO_COUNTY_NAME']
      @COUNTY_NAME_TO_CODE  = @county_yml['COUNTY_NAME_TO_CODE']
      @COUNTY_LAT_LONG      = @county_yml['COUNTY_LAT_LONG']

      ###################################################################
      # self.code_to_name
      #
      # Given a state and county code output the county name
      # Else return nil
      #
      # EX: code_to_name(1, 1) => "AUTAUGA"
      def self.code_to_name(state_code, county_code)
        
        return nil unless @CODE_TO_COUNTY_NAME[state_code.to_s.to_i]

        @CODE_TO_COUNTY_NAME[state_code.to_s.to_i][county_code.to_s.to_i]
      end

      ###################################################################
      # self.name_to_code
      #
      # Given a state and county name output the county code
      # Else return nil
      #
      # EX: name_to_code(1, 'baldwin') => {1 => {"AUTAUGA" => 1, "BALDWIN" => 3, ....}}
      def self.name_to_code(state_code, county_name)
        return nil unless @COUNTY_NAME_TO_CODE[state_code.to_s.to_i]

        @COUNTY_NAME_TO_CODE[state_code.to_s.to_i][county_name.to_s.upcase]
      end


      ###################################################################
      # self.code_to_lat_long
      #
      # Given a state and county code output county latitude longitude.  Else return nil
      #
      def self.code_to_lat_long(state_code, county_code)
        return nil unless @COUNTY_LAT_LONG[state_code.to_s.to_i]

        @COUNTY_LAT_LONG[state_code.to_s.to_i][county_code.to_s.to_i]
      end

      protected
      # Given a state code
      # Return the hash of county code and county names
      def self.state_code_to_county_name_lookup(state_code)
        @code_to_county_name ||= YAML.load_file('county_code_to_name.yml')
        @code_to_county_name[state_code.to_s.to_i]
      end
    end
  end
end
# encoding: UTF-8
module Geolookup
  module USA
    module State
      @state_yml          = YAML.load_file("state.yml")
      @STATE_CODE_TO_FULL = @state_yml['STATE_CODE_TO_FULL']
      @CODE_TO_STATE      = @state_yml['CODE_TO_STATE']
      @STATE_NAME_TO_CODE = @state_yml['STATE_NAME_TO_CODE']

      @FULL_STATE_NAMES   = @state_yml['FULL_STATE_NAMES']
      @STATE_LAT_LONG     = @state_yml['STATE_LAT_LONG']
      @CODE_TO_STATE      = @state_yml['CODE_TO_STATE']
      @STATE_CODE_TO_FULL = @state_yml['STATE_CODE_TO_FULL']
      @STATE_NAME_TO_CODE = @state_yml['STATE_NAME_TO_CODE']
      
      ###################################################################
      # self.code_to_name
      #
      # Given a state code output full state name.  Else return nil
      #
      def self.code_to_name(state_code)
        @STATE_CODE_TO_FULL[state_code.to_s.to_i]
      end

      ###################################################################
      # self.code_to_state_abbreviation
      #
      # Given a state code output the state abbreviation.  Else return nil
      #
      def self.code_to_abbreviation(state_code)
        @CODE_TO_STATE[state_code.to_s.to_i]
      end

      ###################################################################
      # self.name_to_abbreviation
      #
      # Given a state name OR abbreviation return a code.  It takes both an abbreviation and
      # a state full name
      #
      def self.name_to_abbreviation(state_abbrev)
        code_to_name(abbreviation_to_code(state_abbrev))
      end

      ###################################################################
      # self.state_name_to_code
      #
      # Given a state name OR abbreviation return a code.  It takes both an abbreviation and
      # a state full name
      #
      def self.name_to_code(state_name)
        @STATE_NAME_TO_CODE[state_name.to_s.upcase]
      end

      ###################################################################
      # self.state_abbreviation_to_full_name
      #
      # Given a state abbreviation return the full state name
      #
      def self.abbreviation_to_name(state_abbrev)
        @FULL_STATE_NAMES[state_abbrev.to_s.upcase]
      end

      ###################################################################
      # self.name_to_lat_long
      #
      # Given a state name return the lat and long
      #
      def self.name_to_lat_long(name)
        code_to_lat_long(name_to_code(name.to_s.upcase))
      end

      ###################################################################
      # self.code_to_lat_long
      #
      # Given a code return the lat and long
      #
      def self.code_to_lat_long(state_code)
        @STATE_LAT_LONG[state_code.to_s.to_i]
      end

      ###################################################################
      # self.abbreviations
      #
      # Returns an array of state abbreviations
      #
      def self.abbreviations
        @CODE_TO_STATE.values
      end


      ###################################################################
      # self.names
      #
      # Returns an array of state names
      #
      def self.names
        @STATE_CODE_TO_FULL.values
      end

      ###################################################################
      # self.codes
      #
      # Returns an array of state names
      #
      def self.codes
        @STATE_CODE_TO_FULL.keys
      end

      class << self
        alias :abbreviation_to_code :name_to_code
        alias :abbreviation_to_lat_long :name_to_lat_long
      end
    end
  end
end
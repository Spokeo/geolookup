# encoding: UTF-8
module Geolookup
  module USA
    module State
      STATE_CODE_TO_FULL_FILE         = 'STATE_CODE_TO_FULL.yml'
      STATE_CODE_TO_ABBREVIATION_FILE = 'STATE_CODE_TO_STATE.yml'
      STATE_NAME_TO_CODE_FILE         = 'STATE_NAME_TO_CODE.yml'
      STATE_ABBREVIATION_TO_NAME_FILE = 'STATE_FULL_STATE_NAMES.yml'
      STATE_LAT_LONG_FILE             = 'STATE_LAT_LONG.yml'
      TERRITORY_STATES_FILE             = 'TERRITORY_STATES.yml'
      DOMESTIC_STATE_CUTOFF           = 56

      @state_code_to_full
      @state_code_to_abbreviation
      @state_name_to_code
      @state_abbreviation_to_name
      @state_lat_long
      @territory_states
      @domestic_state_code_to_name
      @domestic_state_code_to_abbreviation
      ###################################################################
      # self.code_to_name
      #
      # Given a state code output full state name.  Else return nil
      #
      def self.code_to_name(state_code)
        @state_code_to_full ||= Geolookup.load_hash_from_file(STATE_CODE_TO_FULL_FILE)
        @state_code_to_full[state_code.to_s.to_i]
      end

      ###################################################################
      # self.code_to_state_abbreviation
      #
      # Given a state code output the state abbreviation.  Else return nil
      #
      def self.code_to_abbreviation(state_code)
        @state_code_to_abbreviation ||= Geolookup.load_hash_from_file(STATE_CODE_TO_ABBREVIATION_FILE)
        @state_code_to_abbreviation[state_code.to_s.to_i]
      end

      ###################################################################
      # self.name_to_abbreviation
      #
      # Given a state name OR abbreviation return a code.  It takes both an abbreviation and
      # a state full name
      #
      def self.name_to_abbreviation(state_abbrev)
        code_to_abbreviation(abbreviation_to_code(state_abbrev))
      end

      ###################################################################
      # self.state_name_to_code
      #
      # Given a state name OR abbreviation return a code.  It takes both an abbreviation and
      # a state full name
      #
      def self.name_to_code(state_name)
        @state_name_to_code ||= Geolookup.load_hash_from_file(STATE_NAME_TO_CODE_FILE)
        @state_name_to_code[state_name.to_s.upcase]
      end

      ###################################################################
      # self.state_abbreviation_to_full_name
      #
      # Given a state abbreviation return the full state name
      #
      def self.abbreviation_to_name(state_abbrev)
        @state_abbreviation_to_name ||= Geolookup.load_hash_from_file(STATE_ABBREVIATION_TO_NAME_FILE)
        @state_abbreviation_to_name[state_abbrev.to_s.upcase]
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
        @state_lat_long ||= Geolookup.load_hash_from_file(STATE_LAT_LONG_FILE)
        @state_lat_long[state_code.to_s.to_i]
      end

      ###################################################################
      # self.abbreviations
      #
      # Returns an array of state abbreviations
      #
      def self.abbreviations
        @state_code_to_abbreviation ||= Geolookup.load_hash_from_file(STATE_CODE_TO_ABBREVIATION_FILE)
        @state_code_to_abbreviation.values
      end

      ###################################################################
      # self.abbreviations
      #
      # Returns an array of state abbreviations
      #
      def self.domestic_abbreviations
        @domestic_state_code_to_abbreviation ||= Geolookup.load_hash_from_file(STATE_CODE_TO_ABBREVIATION_FILE).delete_if{|code, abbr| code > DOMESTIC_STATE_CUTOFF}
        @domestic_state_code_to_abbreviation.values
      end


      ###################################################################
      # self.domestic_names
      #
      # Returns an array of domestic state names
      #
      def self.domestic_names
       @domestic_state_code_to_name ||= Geolookup.load_hash_from_file(STATE_CODE_TO_FULL_FILE).delete_if{|code, abbr| code > DOMESTIC_STATE_CUTOFF}
        @domestic_state_code_to_name.values
      end

      ###################################################################
      # self.codes_and_names
      #
      # Returns a hash of state_codes and names
      #
      def self.codes_and_names
        @codes_and_names ||= Geolookup.load_hash_from_file(STATE_CODE_TO_FULL_FILE)
      end

      ###################################################################
      # self.codes_and_abbreviations
      #
      # Returns a hash of state_codes and abbreviations
      #
      def self.codes_and_abbreviations
        @codes_and_abbreviations ||= Geolookup.load_hash_from_file(STATE_CODE_TO_ABBREVIATION_FILE)
      end

      ###################################################################
      # self.abbreviations_and_names
      #
      # Returns a hash of abbreviations and state names
      #
      def self.abbreviations_and_names
        @state_abbreviation_to_name ||= Geolookup.load_hash_from_file(STATE_ABBREVIATION_TO_NAME_FILE)
      end

      ###################################################################
      # self.names
      #
      # Returns an array of state names
      #
      def self.names
        @state_code_to_full ||= Geolookup.load_hash_from_file(STATE_CODE_TO_FULL_FILE)
        @state_code_to_full.values
      end

      ###################################################################
      # self.codes
      #
      # Returns an array of state names
      #
      def self.codes
        @state_code_to_full ||= Geolookup.load_hash_from_file(STATE_CODE_TO_FULL_FILE)
        @state_code_to_full.keys
      end

      ###################################################################
      # self.territory_state_codes
      #
      # Returns an array of territory state codes
      #
      def self.territory_state_codes
        @territory_states ||= Geolookup.load_hash_from_file(TERRITORY_STATES_FILE)
        @territory_states.keys
      end

      ###################################################################
      # self.territory_state_names
      #
      # Returns an array of territory state names
      #
      def self.territory_state_names
        @territory_states ||= Geolookup.load_hash_from_file(TERRITORY_STATES_FILE)
        @territory_states.values
      end

      ###################################################################
      # self.territory?
      #
      # Given a state name, abbreviation, or code, returns true if the
      # state should be territory and false otherwise.
      #
      def self.territory?(state)
        @territory_states ||= Geolookup.load_hash_from_file(TERRITORY_STATES_FILE)
        titlized_state_name = state.to_s.split.map(&:capitalize).join(' ')

        is_territory_state_name = territory_state_names.include? titlized_state_name
        is_territory_state_code = territory_state_codes.include? state.to_i
        is_territory_state_abbreviation = territory_state_names.include? abbreviation_to_name(state)

        is_territory_state_name || is_territory_state_code || is_territory_state_abbreviation
      end

      class << self
        alias :abbreviation_to_code :name_to_code
        alias :abbreviation_to_lat_long :name_to_lat_long
      end
    end
  end
end

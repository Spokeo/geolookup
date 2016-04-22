# encoding: UTF-8
module Geolookup
  module USA
    module Metro
      METRO_CODE_TO_NAME_FILE = 'METRO_CODE_TO_NAME.yml'

      @metro_code_to_name

      ###################################################################
      # self.code_to_name
      #
      # Given a metro code output the metro name
      # Else return nil
      #
      # EX: code_to_name(4) => "Abilene"
      def self.code_to_name(metro_code)
        @metro_code_to_name ||= Geolookup.load_hash_from_file(METRO_CODE_TO_NAME_FILE)
        get_value_from_hash(@metro_code_to_name, metro_code.to_s.to_i)
      end

      ###################################################################
      # self.get_value_from_hash
      #
      # Helper function to reduce code repetition
      # Given a hash and 1 key returns the value at that hash
      # Return nil if the either key is not in the hash
      #
      # EX: get_value(@metro_code_to_name, 4) => "Abilene"
      def self.get_value_from_hash(hash, key1)
        return nil unless hash[key1]
        hash[key1]
      end

      private_class_method :get_value_from_hash
    end
  end
end

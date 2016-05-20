module Geolookup
  module Country
    module PhoneCodes

      COUNTRY_TO_PHONE_CODE_FILE = 'COUNTRY_TO_PHONE_CODE.yml'

      @country_to_phone_code

      def self.country_to_phone_code(country_code)
        @country_to_phone_code ||= Geolookup.load_hash_from_file(COUNTRY_TO_PHONE_CODE_FILE)
        @country_to_phone_code[country_code]
      end
      
      def self.country_phone_codes
        @country_to_phone_code ||= Geolookup.load_hash_from_file(COUNTRY_TO_PHONE_CODE_FILE)
        @country_to_phone_code.values
      end
    end
  end
end

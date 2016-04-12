module Geolookup
  module USA
    module AreaCode

      AREA_CODE_META_INFO_FILE = 'AREA_CODE_META_INFO.yml'

      def self.area_codes_hash
        @area_codes_hash ||= Geolookup.load_hash_from_file(AREA_CODE_META_INFO_FILE)
      end

      def self.info(area_code)
        area_codes_hash[area_code.to_s] || {}
      end
    end
  end
end
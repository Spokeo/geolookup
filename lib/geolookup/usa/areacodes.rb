module Geolookup
  module USA
    module AreaCodes

      AREA_CODE_META_INFO_FILE = 'AREA_CODE_META_INFO.yml'

      def self.to_h
        @area_codes_hash ||= Geolookup.load_hash_from_file(AREA_CODE_META_INFO_FILE)
      end

      def self.find(area_code)
        to_h[area_code.to_s] || {}
      end
    end
  end
end
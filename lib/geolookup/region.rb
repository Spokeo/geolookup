module Geolookup
  module Region
    REGION_CODE_TO_NAME_FILE = 'REGION_CODE_TO_NAME.yml'

    @region_code_to_name
    def self.country_abbr_and_region_code_to_region_name(country_abbr:, region_code:)
      @region_code_to_name ||= Geolookup.load_hash_from_file(REGION_CODE_TO_NAME_FILE)
      region_name = @region_code_to_name.dig(country_abbr.to_s.upcase, region_code.to_s)
      region_name&.downcase&.split(' ')&.map {|word| word.capitalize}&.join(' ')
    end
  end
end

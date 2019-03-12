module Geolookup
  module USA
    module AreaCodes

      AREA_CODE_META_INFO_FILE = 'AREA_CODE_META_INFO.yml'
      AREACODE_POPULATION_FILE = 'CITY_STATE_COUNTY_POPULATION.csv'

      def self.to_h
        @area_codes_hash ||= Geolookup.load_hash_from_file(AREA_CODE_META_INFO_FILE)
      end

      def self.details
        @records ||= Geolookup.load_list_from_csv(AREACODE_POPULATION_FILE).map do |r|
          Detail.new(areacode: r[0].to_i,
                     city: r[1],
                     statecode: r[2].to_i,
                     countycode: r[3].to_i,
                     population: r[4].to_i)
        end
      end

      def self.find(area_code)
        to_h[area_code.to_s] || {}
      end

      # Return a list of detail records for areacode,
      # sorted by population in descending order.
      def self.major_cities(areacode)
        @major_cities_by_areacode ||= create_major_cities_by_areacode
        @major_cities_by_areacode.fetch(areacode.to_i, [])
      end

      # Return a list of areacodes for city and statecode.
      def self.areacodes_by_city_and_statecode(city, statecode)
        @areacodes_by_city_and_state ||= create_areacodes_by_city_and_statecode
        @areacodes_by_city_and_state.fetch(statecode).fetch(city.downcase, [])
      end

      # Return a list of areacodes for countycode and statecode
      def self.areacodes_by_countycode_and_statecode(countycode, statecode)
        @areacodes_by_county_and_state ||= create_areacodes_by_countycode_and_statecode
        @areacodes_by_county_and_state.fetch(statecode).fetch(countycode, [])
      end

      private

      def self.create_areacodes_by_countycode_and_statecode
        h = {}
        details.group_by{ |r| r.statecode }.each do |state, records|
          counties = {}
          h[state] = counties
          records.group_by{ |r| r.countycode }.each do |county, countyrecords|
            counties[county] = countyrecords.map{ |r| r.areacode }.sort.uniq
          end
        end
        h
      end

      def self.create_major_cities_by_areacode
        m = {}
        details.group_by { |r| r.areacode }.each do |code, records|
          m[code] = records.sort_by{ |r| [-r.population, r.city, r.statecode] }
        end
        m
      end

      def self.create_areacodes_by_city_and_statecode
        h = {}
        details.group_by{ |r| r.statecode }.each do |state, records|
          cities = {}
          h[state] = cities
          records.group_by{ |r| r.city }.each do |city, cityrecords|
            cities[city.downcase] = cityrecords.map{ |r| r.areacode }.uniq.sort
          end
        end
        h
      end

      class Detail
        attr_reader :areacode, :city, :statecode, :countycode, :population

        def initialize(areacode:, city:, statecode:, countycode:, population:)
          @areacode = areacode
          @city = city
          @statecode = statecode
          @countycode = countycode
          @population = population
        end

        def state_name
          State.code_to_name(statecode)
        end

        def state_abbrev
          State.code_to_abbreviation(statecode)
        end

        def county_name
          County.code_to_name(statecode, countycode)
        end
      end

    end
  end
end

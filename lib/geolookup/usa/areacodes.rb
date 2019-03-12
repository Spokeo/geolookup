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
          Detail.new(area_code: r[0].to_i,
                     city: r[1],
                     state_code: r[2].to_i,
                     county_code: r[3].to_i,
                     population: r[4].to_i)
        end
      end

      def self.find(area_code)
        to_h[area_code.to_s] || {}
      end

      # Return a list of detail records for area_code,
      # sorted by population in descending order.
      def self.major_cities(area_code)
        @major_cities_by_area_code ||= create_major_cities_by_area_code
        @major_cities_by_area_code.fetch(area_code.to_i, [])
      end

      # Return a list of area_codes for city and state_code.
      def self.area_codes_by_city_and_state_code(city, state_code)
        @area_codes_by_city_and_state ||= create_area_codes_by_city_and_state_code
        @area_codes_by_city_and_state.fetch(state_code).fetch(city.downcase, [])
      end

      # Return a list of area_codes for county_code and state_code
      def self.area_codes_by_county_code_and_state_code(county_code, state_code)
        @area_codes_by_county_and_state ||= create_area_codes_by_county_code_and_state_code
        @area_codes_by_county_and_state.fetch(state_code).fetch(county_code, [])
      end

      private

      def self.create_area_codes_by_county_code_and_state_code
        h = {}
        details.group_by{ |r| r.state_code }.each do |state, records|
          counties = {}
          h[state] = counties
          records.group_by{ |r| r.county_code }.each do |county, countyrecords|
            counties[county] = countyrecords.map{ |r| r.area_code }.sort.uniq
          end
        end
        h
      end

      def self.create_major_cities_by_area_code
        m = {}
        details.group_by { |r| r.area_code }.each do |code, records|
          m[code] = records.sort_by{ |r| [-r.population, r.city, r.state_code] }
        end
        m
      end

      def self.create_area_codes_by_city_and_state_code
        h = {}
        details.group_by{ |r| r.state_code }.each do |state, records|
          cities = {}
          h[state] = cities
          records.group_by{ |r| r.city }.each do |city, cityrecords|
            cities[city.downcase] = cityrecords.map{ |r| r.area_code }.uniq.sort
          end
        end
        h
      end

      class Detail
        attr_reader :area_code, :city, :state_code, :county_code, :population

        def initialize(area_code:, city:, state_code:, county_code:, population:)
          @area_code = area_code
          @city = city
          @state_code = state_code
          @county_code = county_code
          @population = population
        end

        def state_name
          State.code_to_name(state_code)
        end

        def state_abbrev
          State.code_to_abbreviation(state_code)
        end

        def county_name
          County.code_to_name(state_code, county_code)
        end
      end

    end
  end
end

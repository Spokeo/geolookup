module Geolookup
  module USA
    module AreaCodes

      AREA_CODE_META_INFO_FILE = 'AREA_CODE_META_INFO.yml'
      AREA_CODE_POPULATION_FILE = 'CITY_STATE_COUNTY_POPULATION.csv'

      def self.to_h
        @area_codes_hash ||= Geolookup.load_hash_from_file(AREA_CODE_META_INFO_FILE)
      end

      def self.details
        @records ||= Geolookup.load_list_from_csv(AREA_CODE_POPULATION_FILE).map do |r|
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

      def self.area_codes_by_state_code(state_code)
        @area_codes_by_state_code ||= create_area_codes_by_state_code
        @area_codes_by_state_code.fetch(state_code, [])
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

      def self.create_area_codes_by_state_code
        h = {}
        details.group_by{ |r| r.state_code }.each do |state, records|
          h[state] = records.map{ |r| r.area_code }.uniq
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
          add_population!(population)
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

        private

        POP_LOOKUP = {
          ['aiea', 15] => 40281,
          ['captain cook', 15] => 6505,
          ['ewa beach', 15] => 62730,
          ['haiku-pauwela', 15] => 10220,
          ['hana', 15] => 1990,
          ['kahului', 15] => 24816,
          ['kapolei', 15] => 38817,
          ['kaunakakai', 15] => 4503,
          ['kihei', 15] => 26892,
          ['athens', 36] => 3010,
          ['buskirk', 36] => 1172,
          ['cadyville', 36] => 2381,
          ['castleton-on-hudson', 36] => 7851,
          ['childwold', 36] => 65,
          ['craryville', 36] => 1644,
          ['delanson', 36] => 4587,
          ['delmar', 36] => 16918,
          ['eagle bridge', 36] => 1835,
          ['east greenbush', 36] => 9050,
          ['east schodack', 36] => 444,
          ['elizaville', 36] => 1798,
          ['esperance', 36] => 2143,
          ['ghent', 36] => 3418,
          ['hague', 36] => 574,
          ['hoosick falls', 36] => 6262,
          ['lyon mountain', 36] => 546,
          ['moriah', 36] => 1148,
          ['moriah center', 36] => 180,
          ['peru', 36] => 6364,
          ['port henry', 36] => 1599,
          ['schuyler falls', 36] => 1072,
          ['sharon springs', 36] => 2222,
          ['silver bay', 36] => 142,
          ['tupper lake', 36] => 6120,
          ['chicago', 17] => 11110,
          ['amityville', 36] => 27109,
          ['bayport', 36] => 8030,
          ['bellport', 36] => 10401,
          ['brentwood', 36] => 60745,
          ['brightwaters', 36] => 3103,
          ['brookhaven', 36] => 3589,
          ['centerport', 36] => 6292,
          ['central islip', 36] => 35177,
          ['copiague', 36] => 19857,
          ['dix hills', 36] => 47211,
          ['east northport', 36] => 30184,
          ['farmingdale', 36] => 32098,
          ['greenlawn', 36] => 9454,
          ['hauppauge', 36] => 16821,
          ['islandia', 36] => 3345,
          ['lindenhurst', 36] => 45700,
          ['melville', 36] => 19803,
          ['miller place', 36] => 13200,
          ['mount sinai', 36] => 12635,
          ['nesconset', 36] => 14530,
          ['ridge', 36] => 12834,
          ['smithtown', 36] => 35772,
          ['southampton', 36] => 11593,
          ['stony brook', 36] => 18511,
          ['terryville', 36] => 1207,
          ['west babylon', 36] => 40222,
          ['yaphank', 36] => 4990,
        }

        def add_population!(population)
          @population = population
          return if population > 0
          @population = POP_LOOKUP.fetch([city.downcase, state_code], 0)
        end

      end

    end
  end
end

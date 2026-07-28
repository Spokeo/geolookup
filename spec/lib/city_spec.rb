# RAILS_ENV=test rspec spec/lib/city_spec.rb
describe Geolookup::USA::City do

  describe '#find_cities_by_name' do

    it 'should return an empty array if there are no results' do
      expect(Geolookup::USA::City.find_cities_by_name('Testing')).to eq []
    end

    it 'should return a result for a city name that pertains to more than one city' do
      expect(Geolookup::USA::City.find_cities_by_name('fairhope').count).to eq 2
    end

    it 'should return a result for a city name that has only one result' do
      expect(Geolookup::USA::City.find_cities_by_name('los angeles').count).to eq 1
    end

    it 'should have correct data for a city name' do

      cities = Geolookup::USA::City.find_cities_by_name('los angeles')
      los_angeles = cities.first
      expect(los_angeles['state']).to eq 'ca'
      expect(los_angeles['county']).to eq 'los angeles'
    end

    it 'should be case insensitive match' do
      cities = Geolookup::USA::City.find_cities_by_name('StoCkTon')
      expect(cities.count).to eq 17

      expect(cities.first['county']).to eq 'baldwin'
      expect(cities.first['state']).to eq 'al'
    end

    it 'should not die because of nil parameter' do
      cities = Geolookup::USA::City.find_cities_by_name(nil)
      expect(cities).to eq []
    end

    context 'compound census place names' do

      def county_for(name, state)
        Geolookup::USA::City.find_cities_by_name(name)
          .select { |city| city['state'] == state }
          .map { |city| city['county'] }
      end

      it 'should not store any city under a parenthetical key' do
        cities = Geolookup.load_hash_from_file(Geolookup::USA::City::CITY_MAP)
        expect(cities.keys.grep(/[()]/)).to eq []
      end

      it 'should find a city by its primary census name' do
        expect(county_for('bath', 'wv')).to eq ['morgan']
        expect(county_for('raymer', 'co')).to eq ['weld']
        expect(county_for('addison', 'wv')).to eq ['webster']
      end

      it 'should still find a city by its alternate census name' do
        expect(county_for('berkeley springs', 'wv')).to include 'morgan'
        expect(county_for('new raymer', 'co')).to include 'weld'
        expect(county_for('webster springs', 'wv')).to include 'webster'
      end

      it 'should keep pre-existing entries for a reused primary name' do
        expect(county_for('bath', 'me')).to eq ['sagadahoc']
        expect(county_for('addison', 'tx')).to eq ['dallas']
      end

    end

  end

  describe '#find_city_by_zip' do
    it 'finds a city by zip' do
      expect(Geolookup::USA::City.find_city_by_zip('91107')).to eq 'Pasadena'
    end

    it 'returns nil if it cannot find by zip' do
      expect(Geolookup::USA::City.find_city_by_zip('foobar')).to eq nil
    end

  end

end

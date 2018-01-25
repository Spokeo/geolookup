describe 'Geolookup::USA::Cities' do

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
      expect(cities.count).to eq 11

      expect(cities.first['city']).to eq 'stockton'
    end

  end

end
describe 'Geolookup::USA::Zipcodes' do


  describe 'lat_long' do
    it 'should lat long for integer zipcode' do
      expect(Geolookup::USA::Zipcodes.lat_long('90012')).to eql({lat_int: 34067827, long_int: -118242233})
    end

    it 'should lat long for string zipcode' do
      expect(Geolookup::USA::Zipcodes.lat_long(90012)).to eql({lat_int: 34067827, long_int: -118242233})
    end

    it 'should not care about leading zeros' do
      expect(Geolookup::USA::Zipcodes.lat_long(501)).to eql(Geolookup::USA::Zipcodes.lat_long('00501'))
    end

    it 'should return an empty hash if there is no zipcode data' do
      expect(Geolookup::USA::Zipcodes.lat_long('900012')).to eql({})
    end
  end
end

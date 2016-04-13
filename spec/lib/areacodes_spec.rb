describe 'Geolookup::USA::AreaCodes' do


  describe 'info' do
    it 'should return data from the Area Code hash if area code is passed in as a string' do
      expect(Geolookup::USA::AreaCodes.find('202')).to eql({country: 'US', description: '', service: 'y', state: 'DC', type: 'general purpose code'})
    end

    it 'should return data from the Area Code hash if area code is passed in as a number' do
      expect(Geolookup::USA::AreaCodes.find(202)).to eql({country: 'US', description: '', service: 'y', state: 'DC', type: 'general purpose code'})
    end

    it 'should return an empty hash if there is no area_code data' do
      expect(Geolookup::USA::AreaCodes.find(2023)).to eql({})
    end
  end
end

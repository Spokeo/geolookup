describe Geolookup::USA::AreaCodes do


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

  describe '.details' do
    it 'is not empty' do
      expect(described_class.details).to_not be_empty
    end

    it 'is over 9000' do # https://www.youtube.com/watch?v=SiMHTK15Pik
      expect(described_class.details.size>9000).to be_truthy
    end

    it 'uses same list' do
      expect(described_class.details.object_id)
        .to eql(described_class.details.object_id)
    end

    it 'has valid records' do
      described_class.details.each do |r|
        expect(r.areacode>200).to be_truthy, "Failed areacode: #{r}"
        expect(r.city).to_not be_empty, "Failed city: #{r}"
        expect(r.statecode>0).to be_truthy, "Failed state: #{r}"
        expect(r.countycode>0).to be_truthy, "Failed county: #{r}"
        expect(r.population>0).to be_truthy, "Failed population: #{r}"
      end
    end

  end

  describe '.major_cities' do
    it 'creates major cities lookup hash' do
      lookup = described_class.create_major_cities_by_areacode
      expect(lookup).to_not be_empty
      expected_val = 286
      expect(lookup.size >= expected_val)
        .to be_truthy,"Got #{lookup.size}, expected > #{expected_val}"
    end

    it 'returns cities sorted by population descending' do
      cities = described_class.major_cities(949)
      expected_records = Geolookup::USA::AreaCodes.details.select do |r|
        r.areacode == 949
      end.sort_by {|r| -r.population }
      expect(cities).to eql(expected_records)
    end
  end

  describe '.areacodes_by_city_and_state' do
    it 'returns area codes for anaheim' do
      codes = described_class.areacodes_by_city_and_state('anaheim', 6)
      expect(codes).to eql([714, 657].sort)
    end

    it 'returns area codes for anaheim - capitalized' do
      codes = described_class.areacodes_by_city_and_state('ANAHEIM', 6)
      expect(codes).to eql([714, 657].sort)
    end
  end

  describe '.areacodes_by_county_and_state' do
    it 'returns area codes for anaheim' do
      codes = described_class.areacodes_by_county_and_state(59, 6)
      expect(codes).to eql([562, 657, 714, 949].sort)
    end

  end
end

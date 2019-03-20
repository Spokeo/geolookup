# rspec spec/lib/areacodes_spec.rb

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
        expect(r.area_code>200).to be_truthy, "Failed area_code: #{r}"
        expect(r.city).to_not be_empty, "Failed city: #{r}"
        expect(r.state_code>0).to be_truthy, "Failed state: #{r}"
        expect(r.county_code>0).to be_truthy, "Failed county: #{r}"
        expect(r.population>=0).to be_truthy, "Failed population: #{r}"
      end
    end

  end

  describe '.major_cities' do
    it 'returns cities sorted by population descending' do
      cities = described_class.major_cities(949)
      expected_records = Geolookup::USA::AreaCodes.details.select do |r|
        r.area_code == 949
      end.sort_by {|r| -r.population }
      expect(cities).to eql(expected_records)
    end
  end

  describe '.area_codes_by_city_and_state_code' do
    it 'returns area codes for anaheim' do
      codes = described_class.area_codes_by_city_and_state_code('anaheim', 6)
      expect(codes).to eql([714, 657].sort)
    end

    it 'returns area codes for anaheim - capitalized' do
      codes = described_class.area_codes_by_city_and_state_code('ANAHEIM', 6)
      expect(codes).to eql([714, 657].sort)
    end
  end

  describe '.area_codes_by_county_code_and_state_code' do
    it 'returns area codes for anaheim' do
      codes = described_class.area_codes_by_county_code_and_state_code(59, 6)
      expect(codes).to eql([562, 657, 714, 949].sort)
    end

    context 'SPK-37704 - missing area codes' do
      let(:state_and_counties) do
        [ # statename, statecode, state-counties
          ['Hawaii', 15, [3, 7, 1, 9, 5]],
          ['Maine', 23, [5, 1, 19, 31, 11, 3, 23, 9, 13, 27, 29, 21, 15, 17, 25, 7]],
          ['Massachusetts', 25, [9, 17, 21, 25, 23, 27, 13, 3, 15, 11, 5, 1, 7, 19]],
          ['New Hampshire', 33, [11, 13, 17, 5, 15, 1, 9, 19, 7, 3]],
          ['Connecticut', 9, [1, 9, 5, 3, 7, 11, 15, 13]],
          ['New Jersey', 34, [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41]],
          ['Rhode Island', 44, [1, 3, 5, 7, 9]],
          ['Vermont', 50, [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27]],
        ]
      end

      it 'has area codes for state and counties' do
        state_and_counties.each do |name, state, counties|
          counties.each do |county|
            codes = described_class.area_codes_by_county_code_and_state_code(county, state)
            expect(codes).to_not be_empty, "State #{name} (#{state}) does not have area-codes for county #{county}"
          end
        end
      end
    end
  end

  describe 'Detail' do
    let(:record) do
      described_class.details.find do |r|
        r.state_code==6 && r.county_code == 59
      end
    end

    context 'state' do
      it 'returns state_name' do
        expect(record.state_name).to eql('California')
      end

      it 'returns state_abbrev' do
        expect(record.state_abbrev).to eql('CA')
      end
    end

    context 'county' do
      it 'returns county-name' do
        expect(record.county_name).to eql('ORANGE')
      end
    end
  end

end

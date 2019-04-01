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
    it 'has unique cities' do
      cities = described_class.major_cities(347)
      found_cities = Geolookup::USA::AreaCodes.details.select do |r|
        r.area_code == 347
      end
      expect(cities.size).to be < found_cities.size
    end

    it 'returns cities sorted by population descending' do
      cities = described_class.major_cities(949)
      expected_records = Geolookup::USA::AreaCodes.details.select do |r|
        r.area_code == 949
      end.sort_by {|r| -r.population }
      expect(cities).to eql(expected_records)
    end

    it 'has only one state per area-code result' do
      area_codes = described_class.details.map { |r| r.area_code }.uniq
      area_codes.each do |ac|
        major_cities = described_class.major_cities(ac)
        states = major_cities.map{ |r| r.state_code }.uniq
        expect(states.size).to eql(1), "Areacode: #{ac} has states: #{states}"
      end
    end

    context 'fix bug - population missing for major cities for some area-codes' do
      let(:affected_area_codes) do
        [808, 838, 872, 934]
      end

      it 'has records with population' do
        affected_area_codes.each do |ac|
          major_cities = described_class.major_cities(ac)
          expect(major_cities).to_not be_empty
          expect(major_cities[0].population).to be > 0
        end
      end
    end

  end

  describe '.area_codes_by_state_code' do
    it 'returns area_codes' do
      codes = described_class.area_codes_by_state_code(1)
      expect(codes).to_not be_empty
      expect(codes[0]).to be_a(Integer)
    end

    it 'has no area_codes' do
      codes = described_class.area_codes_by_state_code(123)
      expect(codes).to be_empty
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
        [ # statename, min_count, statecode, state-counties
          ['Hawaii', 1, 15, [3, 7, 1, 9, 5]],
          ['Maine', 1, 23, [5, 1, 19, 31, 11, 3, 23, 9, 13, 27, 29, 21, 15, 17, 25, 7]],
          ['Massachusetts', 9, 25, [9, 17, 21, 25, 23, 27, 13, 3, 15, 11, 5, 1, 7, 19]],
          ['New Hampshire', 1, 33, [11, 13, 17, 5, 15, 1, 9, 19, 7, 3]],
          ['Connecticut', 4, 9, [1, 9, 5, 3, 7, 11, 15, 13]],
          ['New Jersey', 9, 34, [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41]],
          ['Rhode Island', 1, 44, [1, 3, 5, 7, 9]],
          ['Vermont', 1, 50, [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27]],
        ]
      end

      it 'has area codes for state and counties' do
        state_and_counties.each do |name, mincount, state, counties|
          allcodes = []
          counties.each do |county|
            codes = described_class.area_codes_by_county_code_and_state_code(county, state)
            expect(codes).to_not be_empty, "County (#{county}) for #{name} is empty."
            allcodes.concat(codes)
          end
          total = allcodes.uniq.size
          failed_msg = "State #{name} (#{state}) not enough area-codes. #{total} < #{mincount}"
          expect(total >= mincount).to be_truthy, failed_msg
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

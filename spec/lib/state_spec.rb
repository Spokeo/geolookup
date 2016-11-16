describe "Geolookup::USA::State" do
  let :state_lat_long do Geolookup::USA::State.name_to_lat_long("Alabama") end
  describe "#code_to_name" do
    it "should return a state name if state code matches" do
      expect(Geolookup::USA::State.code_to_name(1)).to eql("Alabama")
    end

    it "should return nil if code doesn't match" do
      expect(Geolookup::USA::State.code_to_name(-1)).to be_nil
    end
  end

  describe "#name_to_abbreviation" do
    it "should return name to state abbreviation" do
      expect(Geolookup::USA::State.name_to_abbreviation('California')).to eql("CA")
    end

    it "should return nil if no state abbreviation" do
      expect(Geolookup::USA::State.name_to_abbreviation('asdf')).to be_nil
    end
  end

  describe "#state_abbreviations" do
    it "should return an array of state abbreviation" do
      expect(Geolookup::USA::State.abbreviations).to include("CA")
    end
  end

  describe "#names" do
    it "should return an array of state names" do
      expect(Geolookup::USA::State.names).to include("California")
    end
  end

  describe "#codes" do
    it 'should return an array of state codes' do
      expect(Geolookup::USA::State.codes).to include(6)
    end
  end
  
  describe "#territory_state_codes" do
    it 'should return an array of territory state codes' do
      expect(Geolookup::USA::State.territory_state_codes).to include(60)
    end
  end
  
  describe "#territory_state_names" do
    it 'should return an array of territory state names' do
      expect(Geolookup::USA::State.territory_state_names).to include("American Samoa")
    end
  end

  describe "#code_to_abbreviation" do
    it 'should return a state abbreviation gien a state code' do
      expect(Geolookup::USA::State.code_to_abbreviation(1)).to eql("AL")
    end

    it "should return nil if code doesn't match" do
      expect(Geolookup::USA::State.code_to_abbreviation(-1)).to be_nil
    end
  end

  describe "#name_to_code" do
    it "given a state abbrev return the state code" do
      expect(Geolookup::USA::State.name_to_code('ca')).to eql(6)
    end

    it "given a state name return the state code" do
      expect(Geolookup::USA::State.name_to_code('california')).to eql(6)
    end

    it "given a non state name return nil" do
      expect(Geolookup::USA::State.name_to_code('foo')).to be_nil
    end

    it "should gracefully handle nil input" do
      expect(Geolookup::USA::State.name_to_code(nil)).to be_nil
    end
  end

  describe "#abbreviation_to_name" do
    it "given a state abbrev return the state name" do
      expect(Geolookup::USA::State.abbreviation_to_name("CA")).to eql("California")
    end

    it "should gracefully handle nil input" do
      expect(Geolookup::USA::State.abbreviation_to_name(nil)).to be_nil
    end

    it "given a non state abbrev, return nil" do
      expect(Geolookup::USA::State.abbreviation_to_name("CAD")).to be_nil
    end
  end

  describe "#codes_and_names" do
    it "should return a Hash where the key is the code and the value is the full state name" do
      codes_and_names = Geolookup::USA::State.codes_and_names
      expect(codes_and_names).to be_kind_of(Hash)
      expect(codes_and_names[1]).to be_eql("Alabama")
    end
  end

  describe "#codes_and_abbreviations" do
    it "should return a Hash where the key is the code and the value is the state abbrevation" do
      codes_and_abbreviations = Geolookup::USA::State.codes_and_abbreviations
      expect(codes_and_abbreviations).to be_kind_of(Hash)
      expect(codes_and_abbreviations[1]).to be_eql("AL")
    end
  end

  describe "#abbreviations_and_names" do
    it "should return a Hash where the key is the abbreviation and the value is the state name" do
      abbreviations_and_names = Geolookup::USA::State.abbreviations_and_names
      expect(abbreviations_and_names).to be_kind_of(Hash)
      expect(abbreviations_and_names['AL']).to be_eql('Alabama')
    end
  end

  describe "#name_to_lat_long" do
    it "should return a lat / long for state name" do
      expect(Geolookup::USA::State.name_to_lat_long("Alabama")).to eql(state_lat_long)
    end

    it "should return a lat/long for lowercase state name" do
      expect(Geolookup::USA::State.name_to_lat_long("ALABAMA")).to eql(state_lat_long)
    end

    it "should return nil if statename doesn't match" do
      expect(Geolookup::USA::State.name_to_lat_long("AUSTIN LIVES IN YO TESTS")).to be_nil
    end
  end

  describe "#abbreviation_to_code" do
    it "should return a state code for abbreviation" do
      expect(Geolookup::USA::State.abbreviation_to_code("AL")).to eql(1)
    end

    it "should return nil if abbreviation doesn't match" do
      expect(Geolookup::USA::State.abbreviation_to_code("AUSTIN LIVES IN YO TESTS")).to be_nil
    end
  end

  describe "#abbreviation_to_lat_long" do
    it "should return a lat long for a state abbreviation" do
      expect(Geolookup::USA::State.abbreviation_to_lat_long("AL")).to eql(state_lat_long)
    end

    it "should return nil if state abbreviation doesn't match" do
      expect(Geolookup::USA::State.abbreviation_to_lat_long("AUSTIN LIVES IN YO TESTS")).to be_nil
    end
  end

  describe "#code_to_lat_long" do
    it "should return a lat long with a state code int" do
      expect(Geolookup::USA::State.code_to_lat_long(1)).to eql(state_lat_long)
    end

    it "should return a lat long with state code string" do
      expect(Geolookup::USA::State.code_to_lat_long("1")).to eql(state_lat_long)
    end

    it "should return nil if state code doesn't match" do
      expect(Geolookup::USA::State.code_to_lat_long("asdf")).to be_nil
    end
  end

  describe "#domestic_abbreviations" do
    it "should return an array of X states" do
      expect(Geolookup::USA::State.domestic_abbreviations.length).to eql(51)
    end
  end

  describe "#domestic_names" do
    it "should return array of X states" do
      expect(Geolookup::USA::State.domestic_names.length).to eql(51)
    end

    it "should not return Guam" do
      expect(Geolookup::USA::State.domestic_names).to_not include("Guam")
    end
  end

  describe '#territory?' do
    context 'input is a code' do
      context 'code is an integer' do
        context 'state is territory' do
          it 'returns true' do
            state_code = 60
            expect(Geolookup::USA::State.territory?(state_code)).to be true
          end
        end
        context 'state is not territory' do
          it 'returns false' do
            state_code = 1
            expect(Geolookup::USA::State.territory?(state_code)).to be false
          end
        end
      end
      context 'code is a string' do
        context 'state is territory' do
          it 'returns true' do
            state_code = '66'
            expect(Geolookup::USA::State.territory?(state_code)).to be true
          end
        end
        context 'state is not territory' do
          it 'returns false' do
            state_code = '2'
            expect(Geolookup::USA::State.territory?(state_code)).to be false
          end
        end
      end
    end
    context 'input is an abbreviation' do
      context 'casing is all upcase' do
        context 'state is territory' do
          it 'returns true' do
            state_abbreviation = 'MP'
            expect(Geolookup::USA::State.territory?(state_abbreviation)).to be true
          end
        end
        context 'state is not territory' do
          it 'returns false' do
            state_abbreviation = 'AZ'
            expect(Geolookup::USA::State.territory?(state_abbreviation)).to be false
          end
        end
      end
      context 'casing is mixed' do
        context 'state is territory' do
          it 'returns true' do
            state_abbreviation = 'vI'
            expect(Geolookup::USA::State.territory?(state_abbreviation)).to be true
          end
        end
        context 'state is not territory' do
          it 'returns false' do
            state_abbreviation = 'Ar'
            expect(Geolookup::USA::State.territory?(state_abbreviation)).to be false
          end
        end
      end
    end
    context 'input is a state name' do
      context 'casing is all upcase' do
        context 'state is territory' do
          it 'returns true' do
            state_name = 'AMERICAN SAMOA'
            expect(Geolookup::USA::State.territory?(state_name)).to be true
          end
        end
        context 'state is not territory' do
          it 'returns false' do
            state_name = 'CALIFORNIA'
            expect(Geolookup::USA::State.territory?(state_name)).to be false
          end
        end
      end
      context 'casing is mixed' do
        context 'state is territory' do
          it 'returns true' do
            state_name = 'Guam'
            expect(Geolookup::USA::State.territory?(state_name)).to be true
          end
        end
        context 'state is not territory' do
          it 'returns false' do
            state_name = 'CoLoRaDo'
            expect(Geolookup::USA::State.territory?(state_name)).to be false
          end
        end
      end
    end
  end

  describe '#ignored_state_names' do
    it 'returns territory_state_names' do
      expect(Geolookup::USA::State.ignored_state_names).to eq Geolookup::USA::State.territory_state_names
    end
  end

  describe '#ignored_state_codes' do
    it 'returns territory_state_codes' do
      expect(Geolookup::USA::State.ignored_state_codes).to eq Geolookup::USA::State.territory_state_codes
    end
  end

  describe '#ignored?' do
    it 'returns territory' do
      expect(Geolookup::USA::State.ignored?('ca')).to eq Geolookup::USA::State.territory?('ca')
    end
  end
end

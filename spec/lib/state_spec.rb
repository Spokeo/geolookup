describe "geo_state" do
  let(:state_lat_long) { geo_state.name_to_lat_long("Alabama") }
  let(:geo_state) { Geolookup::USA::State }
  let(:unmatching_text) { "AUSTIN LIVES IN YO TESTS" }

  describe "#code_to_name" do
    it "should return a state name if state code matches" do
      expect(geo_state.code_to_name(1)).to eql("Alabama")
    end

    it "should return nil if code doesn't match" do
      expect(geo_state.code_to_name(-1)).to be_nil
    end
  end

  describe "#name_to_abbreviation" do
    it "should return name to state abbreviation" do
      expect(geo_state.name_to_abbreviation('California')).to eql("CA")
    end

    it "should return nil if no state abbreviation" do
      expect(geo_state.name_to_abbreviation('asdf')).to be_nil
    end
  end

  describe "#state_abbreviations" do
    it "should return an array of state abbreviation" do
      expect(geo_state.abbreviations).to include("CA")
    end
  end

  describe "#names" do
    it "should return an array of state names" do
      expect(geo_state.names).to include("California")
    end
  end

  describe "#codes" do
    it 'should return an array of state codes' do
      expect(geo_state.codes).to include(6)
    end
  end

  describe "#territory_state_codes" do
    it 'should return an array of territory state codes' do
      expect(geo_state.territory_state_codes).to include(60)
    end
  end

  describe "#territory_state_names" do
    it 'should return an array of territory state names' do
      expect(geo_state.territory_state_names).to include("American Samoa")
    end
  end

  describe "#district_state_codes" do
    it 'returns an array of district state codes' do
      expect(geo_state.district_state_codes).to include(11)
    end
  end

  describe "#district_state_names" do
    it 'returns an array of district state names' do
      dtt_state_names = geo_state.district_state_names
      expect(dtt_state_names).to include("District of Columbia")
    end
  end

  describe "#code_to_abbreviation" do
    it 'should return a state abbreviation gien a state code' do
      expect(geo_state.code_to_abbreviation(1)).to eql("AL")
    end

    it "should return nil if code doesn't match" do
      expect(geo_state.code_to_abbreviation(-1)).to be_nil
    end
  end

  describe "#name_to_code" do
    it "given a state abbrev return the state code" do
      expect(geo_state.name_to_code('ca')).to eql(6)
    end

    it "given a state name return the state code" do
      expect(geo_state.name_to_code('california')).to eql(6)
    end

    it "given a non state name return nil" do
      expect(geo_state.name_to_code('foo')).to be_nil
    end

    it "should gracefully handle nil input" do
      expect(geo_state.name_to_code(nil)).to be_nil
    end
  end

  describe "#abbreviation_to_name" do
    it "given a state abbrev return the state name" do
      expect(geo_state.abbreviation_to_name("CA")).to eql("California")
    end

    it "should gracefully handle nil input" do
      expect(geo_state.abbreviation_to_name(nil)).to be_nil
    end

    it "given a non state abbrev, return nil" do
      expect(geo_state.abbreviation_to_name("CAD")).to be_nil
    end
  end

  describe "#codes_and_names" do
    it "returns a Hash in which {code: state name}" do
      codes_and_names = geo_state.codes_and_names
      expect(codes_and_names).to be_kind_of(Hash)
      expect(codes_and_names[1]).to be_eql("Alabama")
    end
  end

  describe "#codes_and_abbreviations" do
    it "returns a Hash in which {code: abbrevation}" do
      codes_and_abbreviations = geo_state.codes_and_abbreviations
      expect(codes_and_abbreviations).to be_kind_of(Hash)
      expect(codes_and_abbreviations[1]).to be_eql("AL")
    end
  end

  describe "#abbreviations_and_names" do
    it "returns a Hash in which {code: name}" do
      abbreviations_and_names = geo_state.abbreviations_and_names
      expect(abbreviations_and_names).to be_kind_of(Hash)
      expect(abbreviations_and_names['AL']).to be_eql('Alabama')
    end
  end

  describe "#name_to_lat_long" do
    it "should return a lat / long for state name" do
      expect(geo_state.name_to_lat_long("Alabama")).to eql(state_lat_long)
    end

    it "should return a lat/long for lowercase state name" do
      expect(geo_state.name_to_lat_long("ALABAMA")).to eql(state_lat_long)
    end

    it "should return nil if statename doesn't match" do
      expect(geo_state.name_to_lat_long(unmatching_text)).to be_nil
    end
  end

  describe "#abbreviation_to_code" do
    it "should return a state code for abbreviation" do
      expect(geo_state.abbreviation_to_code("AL")).to eql(1)
    end

    it "should return nil if abbreviation doesn't match" do
      expect(geo_state.abbreviation_to_code(unmatching_text)).to be_nil
    end
  end

  describe "#abbreviation_to_lat_long" do
    it "should return a lat long for a state abbreviation" do
      expect(geo_state.abbreviation_to_lat_long("AL")).to eql(state_lat_long)
    end

    it "should return nil if state abbreviation doesn't match" do
      expect(geo_state.abbreviation_to_lat_long(unmatching_text)).to be_nil
    end
  end

  describe "#code_to_lat_long" do
    it "should return a lat long with a state code int" do
      expect(geo_state.code_to_lat_long(1)).to eql(state_lat_long)
    end

    it "should return a lat long with state code string" do
      expect(geo_state.code_to_lat_long("1")).to eql(state_lat_long)
    end

    it "should return nil if state code doesn't match" do
      expect(geo_state.code_to_lat_long("asdf")).to be_nil
    end
  end

  describe "#domestic_abbreviations" do
    it "should return an array of X states" do
      expect(geo_state.domestic_abbreviations.length).to eql(51)
    end
  end

  describe "#domestic_names" do
    it "should return array of X states" do
      expect(geo_state.domestic_names.length).to eql(51)
    end

    it "should not return Guam" do
      expect(geo_state.domestic_names).to_not include("Guam")
    end
  end

  describe '#territory?' do
    context 'input is a code' do
      context 'code is an integer' do
        context 'state is territory' do
          it 'returns true' do
            state_code = 60
            expect(geo_state.territory?(state_code)).to be true
          end
        end
        context 'state is not territory' do
          it 'returns false' do
            state_code = 1
            expect(geo_state.territory?(state_code)).to be false
          end
        end
      end
      context 'code is a string' do
        context 'state is territory' do
          it 'returns true' do
            state_code = '66'
            expect(geo_state.territory?(state_code)).to be true
          end
        end
        context 'state is not territory' do
          it 'returns false' do
            state_code = '2'
            expect(geo_state.territory?(state_code)).to be false
          end
        end
      end
    end
    context 'input is an abbreviation' do
      context 'casing is all upcase' do
        context 'state is territory' do
          it 'returns true' do
            state_abbreviation = 'MP'
            expect(geo_state.territory?(state_abbreviation)).to be true
          end
        end
        context 'state is not territory' do
          it 'returns false' do
            state_abbreviation = 'AZ'
            expect(geo_state.territory?(state_abbreviation)).to be false
          end
        end
      end
      context 'casing is mixed' do
        context 'state is territory' do
          it 'returns true' do
            state_abbreviation = 'vI'
            expect(geo_state.territory?(state_abbreviation)).to be true
          end
        end
        context 'state is not territory' do
          it 'returns false' do
            state_abbreviation = 'Ar'
            expect(geo_state.territory?(state_abbreviation)).to be false
          end
        end
      end
    end
    context 'input is a state name' do
      context 'casing is all upcase' do
        context 'state is territory' do
          it 'returns true' do
            state_name = 'AMERICAN SAMOA'
            expect(geo_state.territory?(state_name)).to be true
          end
        end
        context 'state is not territory' do
          it 'returns false' do
            state_name = 'CALIFORNIA'
            expect(geo_state.territory?(state_name)).to be false
          end
        end
      end
      context 'casing is mixed' do
        context 'state is territory' do
          it 'returns true' do
            state_name = 'Guam'
            expect(geo_state.territory?(state_name)).to be true
          end
        end
        context 'state is not territory' do
          it 'returns false' do
            state_name = 'CoLoRaDo'
            expect(geo_state.territory?(state_name)).to be false
          end
        end
      end
    end
  end

  describe '#district?' do
    context 'input is a code' do
      context 'code is an integer' do
        context 'state is district' do
          it 'returns true' do
            state_code = 11
            expect(geo_state.district?(state_code)).to be true
          end
        end
        context 'state is not district' do
          it 'returns false' do
            state_code = 1
            expect(geo_state.district?(state_code)).to be false
          end
        end
      end
      context 'code is a string' do
        context 'state is district' do
          it 'returns true' do
            state_code = '11'
            expect(geo_state.district?(state_code)).to be true
          end
        end
        context 'state is not district' do
          it 'returns false' do
            state_code = '2'
            expect(geo_state.district?(state_code)).to be false
          end
        end
      end
    end
    context 'input is an abbreviation' do
      context 'casing is all upcase' do
        context 'state is district' do
          it 'returns true' do
            state_abbreviation = 'DC'
            expect(geo_state.district?(state_abbreviation)).to be true
          end
        end
        context 'state is not district' do
          it 'returns false' do
            state_abbreviation = 'AZ'
            expect(geo_state.district?(state_abbreviation)).to be false
          end
        end
      end
      context 'casing is mixed' do
        context 'state is district' do
          it 'returns true' do
            state_abbreviation = 'dC'
            expect(geo_state.district?(state_abbreviation)).to be true
          end
        end
        context 'state is not district' do
          it 'returns false' do
            state_abbreviation = 'Ar'
            expect(geo_state.district?(state_abbreviation)).to be false
          end
        end
      end
    end
    context 'input is a state name' do
      context 'casing is all upcase' do
        context 'state is district' do
          it 'returns true' do
            state_name = 'DISTRICT OF COLUMBIA'
            expect(geo_state.district?(state_name)).to be true
          end
        end
        context 'state is not district' do
          it 'returns false' do
            state_name = 'CALIFORNIA'
            expect(geo_state.district?(state_name)).to be false
          end
        end
      end
      context 'casing is mixed' do
        context 'state is district' do
          it 'returns true' do
            state_name = 'District OF columbia'
            expect(geo_state.district?(state_name)).to be true
          end
        end
        context 'state is not district' do
          it 'returns false' do
            state_name = 'CoLoRaDo'
            expect(geo_state.district?(state_name)).to be false
          end
        end
      end
    end
  end

  describe '#ignored_state_names' do
    subject { geo_state.ignored_state_names }
    it { is_expected.to eq geo_state.territory_state_names }
  end

  describe '#ignored_state_codes' do
    subject { geo_state.ignored_state_codes }
    it { is_expected.to eq geo_state.territory_state_codes }
  end

  describe '#ignored?' do
    it 'returns territory' do
      expect(geo_state.ignored?('ca')).to eq geo_state.territory?('ca')
    end
  end
end

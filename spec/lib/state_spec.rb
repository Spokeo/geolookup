describe "Geolookup::USA::State" do
  let :state_lat_long do Geolookup::USA::State::STATE_LAT_LONG[1] end

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
      expect(Geolookup::USA::State.name_to_abbreviation('CA')).to eql("California")
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
end
describe "Geolookup::FIPS" do
  describe "#code_to_full_name" do
    it "should return a state name if state code matches" do
      expect(Geolookup::FIPS.code_to_full_name(1)).to eql("Alabama")
    end

    it "should return nil if code doesn't match" do
      expect(Geolookup::FIPS.code_to_full_name(-1)).to be_nil
    end
  end

  describe "#code_to_state_abbreviation" do
    it 'should return a state abbreviation gien a state code' do
      expect(Geolookup::FIPS.code_to_state_abbreviation(1)).to eql("AL")
    end

    it "should return nil if code doesn't match" do
      expect(Geolookup::FIPS.code_to_state_abbreviation(-1)).to be_nil
    end
  end

  describe "#state_name_to_code" do
    it "given a state abbrev return the state code" do
      expect(Geolookup::FIPS.state_name_to_code('ca')).to eql(6)
    end

    it "given a state name return the state code" do
      expect(Geolookup::FIPS.state_name_to_code('california')).to eql(6)
    end

    it "given a non state name return nil" do
      expect(Geolookup::FIPS.state_name_to_code('foo')).to be_nil
    end

    it "should gracefully handle nil input" do
      expect(Geolookup::FIPS.state_name_to_code(nil)).to be_nil
    end
  end

  describe "#state_abbreviation_to_full_name" do
    it "given a state abbrev return the state name" do
      expect(Geolookup::FIPS.state_abbreviation_to_full_name("CA")).to eql("California")
    end

    it "should gracefully handle nil input" do
      expect(Geolookup::FIPS.state_abbreviation_to_full_name(nil)).to be_nil
    end

    it "given a non state abbrev, return nil" do
      expect(Geolookup::FIPS.state_abbreviation_to_full_name("CAD")).to be_nil
    end
  end
end
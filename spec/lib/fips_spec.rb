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
end
require 'spec_helper'


describe "Geolookup::FIPS" do
  describe "self.state_code_to_full_name" do
    it "should return a state name if state code matches" do
      expect(Geolookup::FIPS.full_name(1)).to eql("Alabama")
    end
  end
end
describe "Geolookup::USA::County" do
  describe "#code_to_names" do
    it "given a state code, return a hash of county codes and names" do
      counties = Geolookup::USA::County.code_to_names(1)
      expect(counties).to be_kind_of(Hash)
      expect(counties).to_not be_nil
      county_code = counties.keys.first
      expect(counties[county_code]).to be_kind_of(String)
      # expect(counties[county_code]).to be_kind_of(Array)
      # expect(counties[county_code].first).to be_kind_of(Integer)
      # expect(counties[county_code].last).to be_kind_of(Integer)
    end

  end

  describe "#code_to_lat_longs" do
    it "given a state code return a Hash of county codes and lat and longs" do
      counties = Geolookup::USA::County.code_to_lat_longs(1)
      expect(counties).to be_kind_of(Hash)
      expect(counties).to_not be_nil
      county_code = counties.keys.first
      expect(counties[county_code]).to be_kind_of(Array)
      expect(counties[county_code].first).to be_kind_of(Integer)
      expect(counties[county_code].last).to be_kind_of(Integer)
    end
  end
end
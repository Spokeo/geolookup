describe "Geolookup::Country" do
  describe "#name_to_code" do
    it "returns a country name if country code matches" do
      expect(Geolookup::Country.code_to_name("AL")).to eql("Albania")
    end

    it "returns a country code if country name matches" do
      expect(Geolookup::Country.name_to_code("Hong Kong")).to eql("HK")
    end

    it "returns a lat/long array if country name matches" do
      expect(Geolookup::Country.code_to_lat_long("United States")).to eql([38000000, -97000000])
    end
  end
end
describe "Geolookup::Country" do
  describe "#name_to_code" do
    it "returns a country name if country code matches" do
      expect(Geolookup::Country.code_to_name("AL")).to eql("Albania")
    end

    it "returns a country code if country name matches" do
      expect(Geolookup::Country.name_to_code("Hong Kong")).to eql("HK")
    end

    it "returns a lat/long array if country name matches" do
      expect(Geolookup::Country.name_to_lat_long("United States")).to eql([38000000, -97000000])
    end
  end
  
  describe "#find_country_phone_code" do
    it "expects a country phone code when given a country code" do
      expect(Geolookup::Country::PhoneCodes.country_to_phone_code('DZ')).to eq(213)
    end
    
    it "expects an array of country phone codes" do
      expect(Geolookup::Country::PhoneCodes.country_phone_codes).to include(213)
    end
  end
end

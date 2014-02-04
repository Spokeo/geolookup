describe "Geolookup::USA::County" do
  describe "#code_to_name" do
    it "given a state code, and a county code return the name of the county" do
      expect(Geolookup::USA::County.code_to_name(1, 1)).to eql("AUTAUGA")
    end

    it "should return nil if state key doesn't match" do
      expect(Geolookup::USA::County.code_to_name('yo', 1)).to be_nil
    end
  end

  describe "#code_to_lat_longs" do
    it "given a state code and county code return a lat / long" do
      lat_long = Geolookup::USA::County.code_to_lat_long(1, 1)
      expect(lat_long).to be_kind_of(Array)
    end

    it "should return nil if state key doesn't match" do
      expect(Geolookup::USA::County.code_to_lat_long('yo', 1)).to be_nil
    end
  end

  describe "#name_to_code" do
    it "should return a county code" do
      expect(Geolookup::USA::County.name_to_code(1, 'auTAUGA')).to eql(1)
    end

    it "should return nil if state key doesn't match" do
      expect(Geolookup::USA::County.name_to_code('yo', 'auTAUGA')).to be_nil
    end
  end
end
describe Geolookup::Region do
  describe '#country_abbr_and_region_code_to_region_name' do
    subject { region.country_abbr_and_region_code_to_region_name(country_abbr: country_abbr, region_code: region_code)}
    let(:region) { Geolookup::Region }
    let(:country_abbr) { 'AD' }
    let(:region_code) { '02' }
    let(:region_name) { 'Canillo' }
    context 'country abbreviation and region code combo exists' do
      context 'region name has no special characters' do
        it { is_expected.to eq region_name }
      end
      context 'region name has a space' do
        let(:region_code) { '06' }
        let(:region_name) { 'Sant Julia De Loria' }
        it { is_expected.to eq region_name }
      end
      context 'region name has a comma' do
        let(:country_abbr) { 'LB' }
        let(:region_code) { '10' }
        let(:region_name) { 'Aakk,r' }
        it { is_expected.to eq region_name }
      end
      context 'country abbreviation is lowercase' do
        let(:country_abbr) { 'ad' }
        it { is_expected.to eq region_name }
      end
      context 'country abbreviation is a symbol' do
        let(:country_abbr) { :ad }
        it { is_expected.to eq region_name }
      end
      context 'region code is lowercase' do
        let(:region_code) { '02'.to_sym }
        it { is_expected.to eq region_name }
      end
    end
    context 'country abbreviation and region code combo does not exist' do
      let(:region_code) { '01' }
      it { is_expected.to be_nil }
    end
    context 'country abbreviation does not exist' do
      let(:country_abbr) { 'ZZ' }
      it { is_expected.to be_nil }
    end
  end
end
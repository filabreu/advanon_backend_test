RSpec.shared_examples "site" do |parameter|
  describe "validations" do
    let(:site) { described_class.new }

    it "validates presence of title" do
      expect(site).not_to be_valid
      expect(site.errors.keys).to include(:title)
      expect(site.errors[:title]).to include("can't be blank")
    end
    
    it "validates presence of url" do
      expect(site).not_to be_valid
      expect(site.errors.keys).to include(:url)
      expect(site.errors[:url]).to include("can't be blank")
    end
  end
end
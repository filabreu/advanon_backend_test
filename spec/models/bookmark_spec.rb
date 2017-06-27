require 'rails_helper'
require 'support/shared_examples/site'

RSpec.describe Bookmark, type: :model do
  it_behaves_like "site"

  describe "associations" do
    let(:bookmark) { create(:bookmark) }

    it "belongs to Site" do
      expect(bookmark.site).to be_a(Site)
    end
  end

  describe "#set_site before_validation" do
    context "when Site does not exist" do
      let(:bookmark) { build(:bookmark, site: nil) }

      it "builds a new site" do
        expect(bookmark.site).to be_nil
        expect(bookmark).to be_valid
        expect(bookmark.site).to be_a Site
        expect(bookmark.site.url).to eq "http://mysite.com/"
      end

      it "autosaves the new Site" do
        expect { bookmark.save }.to change {
          Site.where(type: nil).count
        }.by(1)
        .and change {
          Bookmark.count
        }.by(1)
      end
    end

    context "when Site exists" do
      let!(:site) { create(:site) }
      let(:bookmark) { build(:bookmark, site: nil) }
      
      it "sets as parent Site" do
        expect(bookmark.site).to be_nil
        expect(bookmark).to be_valid
        expect(bookmark.site).to eq site
      end
    end
  end
end

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

  describe ".search" do
    let(:bookmark) { create(:bookmark) }

    it "finds by title" do
      expect(Bookmark.search("site")).to include(bookmark)
    end

    it "finds by url" do
      expect(Bookmark.search("mysite")).to include(bookmark)
    end

    it "finds by url_short" do
      expect(Bookmark.search("my.co")).to include(bookmark)
    end
  end

  describe "#tags=" do
    let(:bookmark) { build(:bookmark) }

    it "creates and sets tags separated by commas" do
      bookmark.tags = "tag1, tag 2,tag 3"

      expect(bookmark.tags.size).to eq(3)
    end

    it "saves generated tags" do
      bookmark.tags = "tag1, tag 2,tag 3"

      expect { bookmark.save }.to change { Tag.count }.by(3)
    end

    it "does not create existing tags" do
      Tag.create(name: "tag1")
      bookmark.tags = "tag1, tag 2,tag 3"

      expect { bookmark.save }.to change { Tag.count }.by(2)
    end

    it "removes previously set tags" do
      tag = Tag.create(name: "tag1")
      bookmark.tags = "tag1"

      expect(bookmark.tags).to include(tag)

      bookmark.tags = "tag 2,tag 3"

      expect(bookmark.tags).not_to include(tag)
    end

    it "only create unique tags" do
      bookmark.tags = "tag1, tag1, tag1"

      expect { bookmark.save }.to change { Tag.count }.by(1).and change { Tagging.count }.by(1)
    end
  end

end

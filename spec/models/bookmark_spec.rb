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

end

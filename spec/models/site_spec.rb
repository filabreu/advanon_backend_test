require 'rails_helper'
require 'support/shared_examples/site'

RSpec.describe Site, type: :model do
  it_behaves_like "site"

  describe ".toplevel_url" do
    it "matches toplevel of an url" do
      expect(Site.toplevel_url("http://example.com/abc")).to eq "http://example.com/"
      expect(Site.toplevel_url("http://example.com")).to eq "http://example.com"
      expect(Site.toplevel_url("https://example.com/abc")).to eq "https://example.com/"
      expect(Site.toplevel_url("https://example.com/abc/def")).to eq "https://example.com/"
      expect(Site.toplevel_url("https://example.com.br/abc/def")).to eq "https://example.com.br/"
      expect(Site.toplevel_url("https://example/abc")).to eq ""
      expect(Site.toplevel_url("htt://example.com/abc")).to eq ""
    end
  end

  describe ".find_from_toplevel_url" do
    let!(:site) { create(:site) }

    it "finds Site instance from toplevel part of url" do
      expect(Site.find_from_toplevel_url("http://mysite.com/abc/def")).to eq site
    end
  end
end

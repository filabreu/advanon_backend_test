class Site < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true

  def toplevel_url=(value)
    self.url = self.class.toplevel_url(value) if value
  end

  private

    def self.find_from_toplevel_url(value)
      where(url: self.toplevel_url(value)).first if value
    end

    def self.toplevel_url(value)
      value.match(/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})\/?/).to_s if value
    end
end

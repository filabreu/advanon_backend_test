class Bookmark < Site
  belongs_to :site
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  before_validation :set_site

  def self.search(query)
    return self.all unless query

    where("url ILIKE ? or url_short ILIKE ? or title ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
  end

  def tags=(values)
    records = []
    values.strip.split(/\,\s*/).each do |tag|
      records << Tag.find_or_initialize_by(name: tag)
    end

    records.uniq! { |record| record.name }

    records.each do |record|
      self.tags << record unless self.tags.include?(record) or !record.valid?
    end

    self.tags.each do |tag|
      self.tags.delete(tag) unless records.include?(tag)
    end
  end

  protected

    def set_site
      toplevel_site = Site.find_from_toplevel_url(self.url)
      if toplevel_site
        self.site = toplevel_site
      else
        self.build_site(title: self.title, toplevel_url: self.url)
      end
    end
end

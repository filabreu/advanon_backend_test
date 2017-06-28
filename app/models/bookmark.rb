class Bookmark < Site
  belongs_to :site

  before_validation :set_site

  def self.search(query)
    return self.all unless query

    where("url ILIKE ? or url_short ILIKE ? or title ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
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

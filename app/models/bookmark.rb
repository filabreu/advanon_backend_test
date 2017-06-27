class Bookmark < Site
  belongs_to :site

  before_validation :set_site

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

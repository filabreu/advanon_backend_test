module BookmarksHelper

  def bookmark_tags(bookmark)
    bookmark.tags.map(&:name).join(", ")
  end
end

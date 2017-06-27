FactoryGirl.define do
  factory :bookmark do
    site
    title "My Site"
    sequence :url do |n|
      "http://mysite.com/#{n}"
    end
    sequence :url_short do |n|
      "http://my.co/#{n}"
    end
  end
end

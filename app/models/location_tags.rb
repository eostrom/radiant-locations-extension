module LocationTags
  include Radiant::Taggable
  
  desc "Gives access to a page's location, and adds it to the current map if there is one."
  tag 'location' do |tag|
    location = tag.locals.page.location || Location.new(:page_id => tag.locals.page)
    if location
      tag.locals.location = location
      tag.locals.map.locations << location if tag.locals.map
      tag.expand
    end
  end
  
  desc "Renders the page's address."
  tag 'location:address' do |tag|
    tag.locals.location.address
  end
  
  desc "Renders the page's coordinates."
  tag 'location:coordinates' do |tag|
    tag.locals.location.coordinates
  end
end

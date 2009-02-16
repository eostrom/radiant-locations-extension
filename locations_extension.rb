# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class LocationsExtension < Radiant::Extension
  version "1.0"
  description "Creates maps based on page locations"
  url "http://github.com/eostrom/radiant-locations-extension"
  
  # define_routes do |map|
  #   map.connect 'admin/locations/:action', :controller => 'admin/locations'
  # end
  
  def activate
    # admin.tabs.add "Locations", "/admin/locations", :after => "Layouts", :visibility => [:all]
    Page.send :include, WithLocation
    Page.send :include, LocationTags
    
    admin.page.edit.add(:parts_bottom, 'location')
  end
  
  def deactivate
    # admin.tabs.remove "Locations"
  end
  
end

# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class LocationsExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/locations"
  
  # define_routes do |map|
  #   map.connect 'admin/locations/:action', :controller => 'admin/locations'
  # end
  
  def activate
    # admin.tabs.add "Locations", "/admin/locations", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Locations"
  end
  
end
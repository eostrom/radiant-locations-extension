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
    Page.class_eval do
      has_one :location, :dependent => :destroy # one, for now...
      validates_associated :location
    end
    
    admin.page.edit.add(:parts_bottom, 'location')
  end
  
  def deactivate
    # admin.tabs.remove "Locations"
  end
  
end

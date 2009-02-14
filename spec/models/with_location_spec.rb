require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  before(:each) do
    @page = Page.new(
      :title => 'Anno Domini',
      :slug => 'anno-domini',
      :breadcrumb => 'A.D.',
      :status => Status[:draft]
    )
    
    @location_attrs = HashWithIndifferentAccess.new(
      :page => @page,
      :address => "366 S. 1st St., 95113",
      :latitude => 37.331061,
      :longitude => -121.886079
    )
    
    @location = Location.new(@location_attrs)

    # TODO: make this configurable
    @geocoder = Geokit::Geocoders::GoogleGeocoder
  end

  it "should be valid with no location" do
    @geocoder.should_not_receive(:geocode)
    @page.should be_valid
  end

  it "should be valid with valid location" do
    geocoder_succeed
    @page.location = @location
    @page.should be_valid
  end
  
  it "should be invalid with invalid location" do
    geocoder_fail
    @page.location = @location
    @page.should_not be_valid
  end
  
  it "should accept a Location" do
    @page.location = @location
    @page.location.should == @location
  end
  
  it "should accept a HashWithIndifferentAccess" do
    @page.location.should == nil
    @page.location = @location_attrs
    @page.location.attributes.should_not == nil
  end
end

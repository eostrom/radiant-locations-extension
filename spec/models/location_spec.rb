require File.dirname(__FILE__) + '/../spec_helper'
require 'geokit'

describe Location do
  before(:each) do
    @page = Page.new(
      :title => 'Anno Domini',
      :slug => 'anno-domini',
      :breadcrumb => 'A.D.',
      :status => Status[:draft]
    )
    
    @location = Location.new(
      :page => @page,
      :address => "366 S. 1st St., 95113",
      :latitude => 37.331061,
      :longitude => -121.886079
    )
    
    # TODO: make this configurable
    @geocoder = Geokit::Geocoders::GoogleGeocoder
    @geocoder.stub!(:geocode).and_return(
      mock('geo', :success => true, :lat => 37.331061, :lng => -121.886079)
    )
  end

  it "should be valid if the geocoder succeeds" do
    @location.should be_valid
  end
  
  it "should be invalid if the geocoder fails" do
    geocoder_fail!
    @location.should_not be_valid
  end

  it "should bypass the geocoder if the address is blank" do
    geocoder_skip!
    @location.address = ""
    @location.should be_valid
    @location.latitude.should == nil
    @location.longitude.should == nil
  end
  
  it "should look up coordinates if the Location is new" do
    @geocoder.should_receive(:geocode).with(@location.address).and_return(
      mock('geo', :success => true, :lat => 37.331061, :lng => -121.886079)
    )
    @location.valid?
  end

  it "should look up coordinates if the address has changed" do
    @location.save!
    @location.address = '315 S 1st St, San Jose, CA'
    @geocoder.should_receive(:geocode).with(@location.address).and_return(
      mock('geo', :success => true, :lat => 37.3313718, :lng => -121.8869519)
    )
    @location.valid?
  end
  
  it "should not look up coordinates if the address hasn't changed" do
    @location.save!
    @location.address = @location.address
    @geocoder.should_not_receive(:geocode)
    @location.valid?
  end

  it "should not look up coordinates if the address is blank" do
    @location.address = ''
    @geocoder.should_not_receive(:geocode)
    @location.valid?
  end
  
  it "should render its coordinates as a string" do
    @location.coordinates.should match(/37.*121/)
  end

  it "should render its coordinates as nil when blank" do
    @location.latitude = @location.longitude = nil
    @location.coordinates.should == nil
  end
end

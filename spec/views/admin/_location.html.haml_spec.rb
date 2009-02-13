require File.dirname(__FILE__) + '/../../spec_helper'

describe '_location partial' do
  before(:each) do
    assigns[:page] = mock_model(Page)
    @address = '366 S. 1st St., 95113'
    @coordinates = '37.331061 N, 121.886079 W'
  end
  
  it "should render blank address and coordinates if the page has no location" do
    assigns[:page].should_receive(:location).and_return(nil)

    render :partial => '/admin/page/location'
    
    response.should_not have_tag('input[name=?][value=?]', /.*address.*/, /.*/)
    response.should_not have_tag('input[name=?][value=?]', /.*coordinates.*/, /.*/)
  end
  
  it "should render address and coordinates if the page has a location" do
    location = mock_model(Location)
    location.should_receive(:address).and_return(@address)
    location.should_receive(:coordinates).and_return(@coordinates)
    assigns[:page].should_receive(:location).and_return(location)

    render :partial => '/admin/page/location'

    response.should have_tag('input[name=?][value=?]', /.*address.*/, @address)
    response.should have_tag('input[name=?][value=?]', /.*coordinates.*/, @coordinates)
  end
  
  it "should render address and no coordinates if the page has an invalid location" do
    location = mock_model(Location)
    location.should_receive(:address).and_return(@address)
    location.should_receive(:coordinates).and_return(nil)
    assigns[:page].should_receive(:location).and_return(location)

    render :partial => '/admin/page/location'

    response.should have_tag('input[name=?][value=?]', /.*address.*/, @address)
    response.should_not have_tag('input[name=?][value=?]', /.*coordinates.*/, /.*/)
  end
end

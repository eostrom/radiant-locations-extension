require File.dirname(__FILE__) + '/../spec_helper'

describe "Location Tags" do
  scenario :location_pages
  
  it "<r:location:address> should render the page's address" do
    pages(:anno_domini).should(
      render('<r:location:address/>').as('366 S. 1st Street, San Jose, CA 95113')
    )
  end
  
  it "<r:location:address> should be blank if the page's location is" do
    pages(:venues).should render('<r:location:address/>').as('')
  end
  
  it "<r:location:coordinates> should render the page's coordinates" do
    pages(:anno_domini).should(
      render('<r:location:coordinates/>').as(/37.*N.*121.*W/)
    )
  end
end

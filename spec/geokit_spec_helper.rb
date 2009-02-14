module GeokitSpecHelper
  def success
    mock('geo', :success => true, :lat => 37.331061, :lng => -121.886079)
  end
  
  def failure
    mock('geo', :success => false, :lat => nil, :lng => nil)
  end
  
  def geocoder_succeed
    @geocoder.stub!(:geocode).and_return(success)
  end
  
  def geocoder_fail
    @geocoder.stub!(:geocode).and_return(failure)
  end
  
  def geocoder_succeed!
    @geocoder.should_receive(:geocode).at_least(:once).and_return(success)
  end

  def geocoder_fail!
    @geocoder.should_receive(:geocode).at_least(:once).and_return(failure)
  end
  
  def geocoder_skip!
    @geocoder.should_not_receive(:geocode)
  end
end

class LocationPagesScenario < Scenario::Base
  uses :home_page
  
  def load
    create_page "Venues" do
      create_page "Anno Domini"
    end
    
    pages(:anno_domini).location = {
      :address => '366 S. 1st Street, San Jose, CA 95113'
    }
  end
end

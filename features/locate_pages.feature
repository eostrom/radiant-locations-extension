Feature: Locate pages
  In order to inform visitors to my web site
  As a content creator
  I want to associate pages with locations

  Scenario: Successfully set a page's location by address
    Given I am logged in as "Rita"
    When I visit the "Anno Domini" admin page
    And I fill in "Address" with "366 So. First Street, San Jose, CA 95113"
    And I press "Save and Continue Editing"
    Then I should see "37[^a-z]*N"
    And I should see "121[^a-z]*W"

  Scenario: Accept the geocoder's spelling of an address

  Scenario: Reject the geocoder's spelling of an address

  Scenario: Successfully set a page's location by coordinates

  Scenario: Fail to set a page's location

  Scenario: Unset a page's location

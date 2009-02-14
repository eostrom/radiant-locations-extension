Feature: Locate pages
  In order to inform visitors to my web site
  As a content creator
  I want to associate pages with locations

  Scenario: Successfully create a page with a location
    Given I am logged in as "Rita"
    When I add a child to the "Venues" page
    And I fill in "Page Title" with "San Jose Museum of Quilts & Textiles"
    And I fill in "Slug" with "quilts-and-textiles"
    And I fill in "Breadcrumb" with "Quilts & Textiles"
    And I fill in "Address" with "520 S 1st St, 95113"
    And I press "Save and Continue Editing"
    Then I should see "37[^a-z]*N"
    And I should see "121[^a-z]*W"

  Scenario: Successfully create a page without a location
    Given I am logged in as "Rita"
    When I add a child to the "First Fridays" page
    And I fill in "Page Title" with "About"
    And I fill in "Slug" with "about"
    And I fill in "Breadcrumb" with "About"
    And I press "Save and Continue Editing"
    Then I should not see "Validation errors"

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
    Given I am logged in as "Rita"
    When I visit the "Anno Domini" admin page
    And I fill in "Address" with "auhy euh ser"
    And I press "Save and Continue Editing"
    Then I should see "Couldn't find address"

  Scenario: Unset a page's location

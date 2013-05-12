Feature: Viewer visits the Home Page
  In order to read the page
  As a viewer
  I want to see the home page of my app
  
Scenario: View home page
  Given I am on the home page
  Then I should see "Please login"
  
Scenario: Find heading on home page
  Given I am on the home page
  Then I should see "found" in the selector "title"
  
Scenario: Find the link to the form
  Given I am on the home page
  Then I should see "Sign-In" in a link

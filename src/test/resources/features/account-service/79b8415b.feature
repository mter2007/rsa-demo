Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  @SRADEMO-258
  Scenario: Session timeout prompts re-authentication
    Given I am logged in as participant "john.smith@email.com" with password "SecurePass123!"
    And I am viewing my retirement account balance of "$125,750.00"
    And my session has been active for 29 minutes
    When my session expires after 30 minutes of activity
    And I attempt to refresh my account balance
    Then I should see a session timeout message "Your session has expired for security reasons"
    And I should be redirected to the login page
    When I log in again with username "john.smith@email.com" and password "SecurePass123!"
    Then I should successfully access my retirement account balance
    And I should see my account balance of "$125,750.00"
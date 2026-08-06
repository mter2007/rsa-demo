Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  @SRADEMO-258
  Scenario: Display account balance on Account Summary page when account service is unavailable
    Given the participant "john.smith@example.com" is logged into the system
    And the participant has an active retirement account with ID "ACC-789456"
    And the account service is unavailable
    When the participant navigates to the Account Summary page
    Then an error message "Unable to retrieve account balance at this time. Please try again later." should be displayed
    And the account balance section should show "N/A"
    And the page should provide a "Retry" button

  @SRADEMO-258
  Scenario: Display account balance on Account Summary page for non-existent account
    Given the participant "jane.doe@example.com" is logged into the system
    And the participant does not have any retirement accounts
    When the participant navigates to the Account Summary page
    Then an informational message "No retirement account found. Contact HR to set up your account." should be displayed
    And the account balance section should not be visible
    And a "Contact Support" link should be displayed

  @SRADEMO-258
  Scenario: Display account balance on Account Summary page for suspended account
    Given the participant "mike.johnson@example.com" is logged into the system
    And the participant has a suspended retirement account with ID "ACC-654321"
    And the account was suspended on "2024-01-15"
    When the participant navigates to the Account Summary page
    Then a warning message "Your account is currently suspended. Please contact customer service." should be displayed
    And the last known account balance of "$45,230.75" should be displayed
    And the balance should be marked with a "As of: 2024-01-15" timestamp
    And contribution details should not be displayed
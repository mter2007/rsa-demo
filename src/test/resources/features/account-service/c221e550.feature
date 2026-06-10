@SRADEMO-258
Feature: Retirement Account Balance Display
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  Scenario: Participant sees 'No holdings found' message when account has zero balance
    Given participant "John Smith" has account number "ACC-789012" with the account service
    And the account "ACC-789012" has a balance of 0.00 USD
    And the account "ACC-789012" has no holdings
    When the participant requests to view balance for account "ACC-789012"
    Then the response status should be 200
    And the account balance displayed should be 0.00 USD
    And the message "No holdings found" should be displayed
    And no investment holdings should be listed
@SRADEMO-258
Feature: Retirement Account Balance Viewing
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  Scenario: Balance accuracy at exactly 24 hours
    Given a participant with account number "ACC-2024-789456"
    And the account has a balance of 125000.00 USD
    And the balance was last updated at "2024-01-15T10:00:00Z"
    And the current time is "2024-01-16T10:00:00Z"
    When the participant requests their account balance
    Then the account balance should display 125000.00 USD
    And the balance timestamp should be "2024-01-15T10:00:00Z"
    And the balance age should be "24 hours"
    And the balance freshness indicator should be "current"
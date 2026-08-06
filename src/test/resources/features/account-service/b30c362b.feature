@SRADEMO-258
Feature: Retirement Account Balance Tracking
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  Scenario: Account transitions from zero to non-zero balance
    Given a participant with account number "401K-987654" exists
    And the participant account "401K-987654" has a balance of 0.00 USD
    When the participant views their retirement account balance for "401K-987654"
    Then the account balance should display 0.00 USD
    When a contribution of 500.00 USD is made to account "401K-987654"
    And the participant views their retirement account balance for "401K-987654"
    Then the account balance should display 500.00 USD
    And the account status should be "Active"
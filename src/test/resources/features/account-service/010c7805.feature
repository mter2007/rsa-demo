@SRADEMO-258
Feature: Retirement Account Balance Display
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  Scenario: Balance displayed matches official end-of-day NAV when last transaction was processed more than 24 hours ago
    Given the participant has account "RET-2024-7891" in the account service
    And the account "RET-2024-7891" has 1250.50 shares
    And the last transaction for account "RET-2024-7891" was processed on "2024-01-15T14:30:00Z"
    And the current system time is "2024-01-17T10:00:00Z"
    And the official end-of-day NAV for "2024-01-16" is 42.75 per share
    When the participant requests the balance for account "RET-2024-7891"
    Then the displayed balance should be 53459.63
    And the balance calculation should use the NAV value of 42.75
    And the NAV date should be displayed as "2024-01-16"
    And the balance source should be indicated as "Official End-of-Day NAV"
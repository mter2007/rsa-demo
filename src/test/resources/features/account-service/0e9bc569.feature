@SRADEMO-258
Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  Scenario: Balance matches official NAV after 24 hours
    Given the participant "John Smith" has account number "RET-2024-001"
    And the account has the following holdings:
      | Fund Code | Fund Name                | Units   | Official NAV | Purchase Date |
      | EQFD-500  | Equity Growth Fund       | 1000.50 | 125.75       | 2024-01-15    |
      | BDFD-100  | Bond Income Fund         | 500.25  | 98.50        | 2024-01-20    |
      | MMFD-200  | Money Market Fund        | 2500.00 | 10.00        | 2024-02-01    |
    And the official NAV was published 24 hours ago at "2024-03-15T16:00:00Z"
    And the NAV data has been synced to the account service
    When the participant "John Smith" requests their account balance for account "RET-2024-001"
    Then the displayed balance should be "200562.96"
    And the balance calculation should be:
      | Fund Code | Units   | NAV    | Value     |
      | EQFD-500  | 1000.50 | 125.75 | 125812.88 |
      | BDFD-100  | 500.25  | 98.50  | 49274.63  |
      | MMFD-200  | 2500.00 | 10.00  | 25000.00  |
    And the NAV as of date should be "2024-03-15T16:00:00Z"
    And the balance should be marked as "official"
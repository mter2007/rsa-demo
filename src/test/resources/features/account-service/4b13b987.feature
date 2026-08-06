@SRADEMO-258
Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  Scenario: Display account balance on Account Summary page
    Given the participant "John Smith" is logged into the system
    And the participant has an active retirement account "401K-12345"
    And the account "401K-12345" has the following balance information:
      | Balance Type      | Amount    |
      | Employee Contributions | 25000.00  |
      | Employer Match         | 12500.00  |
      | Investment Earnings    | 8750.50   |
      | Total Balance          | 46250.50  |
    When the participant navigates to the Account Summary page
    Then the page displays the account number "401K-12345"
    And the page displays the total account balance as "$46,250.50"
    And the page displays the employee contributions as "$25,000.00"
    And the page displays the employer match as "$12,500.00"
    And the page displays the investment earnings as "$8,750.50"
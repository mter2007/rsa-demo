@SRADEMO-258
Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  Scenario: Participant sees current account balance with breakdown by investment fund on Account Summary page
    Given participant "John Smith" is logged into the system
    And participant "John Smith" has an active retirement account "ACC-789456"
    And the account "ACC-789456" has the following investment fund allocations:
      | Fund Name                    | Fund Code | Units  | Unit Price | Market Value |
      | Global Equity Growth Fund    | GEF-001   | 1250.5 | 42.50      | 53146.25     |
      | Fixed Income Stability Fund  | FIS-002   | 890.25 | 28.75      | 25594.69     |
      | Balanced Index Fund          | BIF-003   | 675.0  | 35.20      | 23760.00     |
      | International Bond Fund      | IBF-004   | 420.75 | 22.10      | 9298.58      |
    And the total account balance is "111799.52"
    When participant "John Smith" navigates to the Account Summary page
    Then the current account balance displays "111799.52"
    And the account balance breakdown shows:
      | Fund Name                    | Market Value |
      | Global Equity Growth Fund    | 53146.25     |
      | Fixed Income Stability Fund  | 25594.69     |
      | Balanced Index Fund          | 23760.00     |
      | International Bond Fund      | 9298.58      |
    And the total of all fund values equals the account balance "111799.52"
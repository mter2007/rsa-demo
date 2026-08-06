Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  @SRADEMO-258
  Scenario: View detailed fund holdings
    Given the participant "John Smith" has an active retirement account "ACC-789456"
    And the account "ACC-789456" has the following fund holdings:
      | Fund Name                    | Fund Code | Units    | Price Per Unit | Current Value | Percentage |
      | Growth Equity Fund           | GEF001    | 1250.50  | 45.67         | 57103.34      | 42.5       |
      | Bond Index Fund              | BIF002    | 2000.00  | 12.34         | 24680.00      | 18.4       |
      | International Stock Fund     | ISF003    | 850.75   | 32.18         | 27377.13      | 20.4       |
      | Small Cap Value Fund         | SCV004    | 500.00   | 52.15         | 26075.00      | 19.4       |
    And the total account balance is "135235.47"
    When the participant requests detailed fund holdings for account "ACC-789456"
    Then the system should return all fund holdings
    And the response should include the following funds:
      | Fund Code | Fund Name                    |
      | GEF001    | Growth Equity Fund           |
      | BIF002    | Bond Index Fund              |
      | ISF003    | International Stock Fund     |
      | SCV004    | Small Cap Value Fund         |
    And each fund holding should display units held
    And each fund holding should display current price per unit
    And each fund holding should display current value
    And each fund holding should display percentage of total portfolio
    And the total account balance should be "135235.47"
    And the sum of all fund values should equal the total account balance
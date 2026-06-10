@SRADEMO-258
Feature: Retirement Account Balance Viewing
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  Scenario: View details for fund with fractional units
    Given participant "john.doe@example.com" has an active retirement account "RET-100542"
    And the account "RET-100542" has the following fund holdings:
      | Fund Code | Fund Name                    | Units      | Price Per Unit | Total Value |
      | VTSAX     | Vanguard Total Stock Market  | 125.847    | 112.45         | 14152.54    |
      | VBTLX     | Vanguard Total Bond Market   | 89.3267    | 11.89          | 1062.09     |
      | VTIAX     | Vanguard Total International | 47.12      | 30.75          | 1448.94     |
    When participant "john.doe@example.com" requests balance details for account "RET-100542"
    Then the response status code should be 200
    And the account balance details should include:
      | Fund Code | Fund Name                    | Units      | Price Per Unit | Total Value |
      | VTSAX     | Vanguard Total Stock Market  | 125.847    | 112.45         | 14152.54    |
      | VBTLX     | Vanguard Total Bond Market   | 89.3267    | 11.89          | 1062.09     |
      | VTIAX     | Vanguard Total International | 47.12      | 30.75          | 1448.94     |
    And the total account balance should be 16663.57
    And all unit values should be displayed with decimal precision
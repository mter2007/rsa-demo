@SRADEMO-258
Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  Scenario: Attempt to view details for fund with no holdings
    Given participant "John Doe" with account number "ACC123456" exists in the system
    And participant "John Doe" has an active retirement account
    And the following funds are available in the system:
      | Fund Code | Fund Name                    | Fund Type |
      | VANG500   | Vanguard 500 Index Fund     | Equity    |
      | BONDMKT   | Total Bond Market Fund      | Fixed     |
    And participant "John Doe" has the following fund holdings:
      | Fund Code | Shares | Current Value |
      | VANG500   | 150.50 | 25000.00      |
    When participant "John Doe" requests details for fund "BONDMKT"
    Then the response status should be 404
    And the response should contain error message "No holdings found for fund BONDMKT"
    And the account balance should remain unchanged at 25000.00
@SRADEMO-258
Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  Scenario: Participant sees detailed holdings including units, unit price, and total value when clicking on a fund name
    Given the participant "John Smith" with account number "ACC123456" is logged in
    And the participant has the following fund holdings:
      | Fund Name                    | Units    | Unit Price | Total Value |
      | Global Equity Growth Fund    | 1250.50  | 45.75      | 57210.38    |
      | Conservative Bond Fund       | 3000.00  | 12.50      | 37500.00    |
      | Emerging Markets Fund        | 500.25   | 28.30      | 14157.08    |
    And the participant is viewing their account balance summary page
    When the participant clicks on the fund name "Global Equity Growth Fund"
    Then the detailed holdings page for "Global Equity Growth Fund" is displayed
    And the holdings details show units as "1250.50"
    And the holdings details show unit price as "45.75"
    And the holdings details show total value as "57210.38"
@SRADEMO-258
Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  Scenario: Display account with minimal non-zero balance (Negative)
    Given participant "John Smith" with participant ID "PS123456" exists in the system
    And participant "PS123456" has a retirement account "RET-987654321"
    And the retirement account "RET-987654321" has a balance of 0.01 dollars
    When participant "PS123456" requests to view their retirement account balance
    Then the system should return an error with code "INSUFFICIENT_BALANCE"
    And the error message should be "Account balance below minimum display threshold of $1.00"
    And the account balance should not be displayed
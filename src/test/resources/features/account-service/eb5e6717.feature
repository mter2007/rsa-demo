Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  @SRADEMO-258
  Scenario: Display account balance with pending transactions
    Given the participant "John Smith" has an account with ID "ACC-78945"
    And the account has a confirmed balance of 125000.00
    And the account has the following pending transactions:
      | Transaction ID | Type        | Amount   | Date       | Description           |
      | TXN-001       | Contribution | 500.00   | 2024-01-15 | Bi-weekly contribution|
      | TXN-002       | Contribution | 250.00   | 2024-01-16 | Employer match        |
      | TXN-003       | Withdrawal   | -1000.00 | 2024-01-17 | Loan payment          |
    When the participant requests their account balance
    Then the confirmed balance should be 125000.00
    And the pending balance should be -250.00
    And the projected balance should be 124750.00
    And the pending transactions should be displayed with their status as "Pending"
    And the total number of pending transactions should be 3
Feature: Retirement Account Balance Viewing
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  @SRADEMO-258
  Scenario: Balance with recent transactions under 24 hours (Negative)
    Given the participant "John Smith" has an account with ID "ACC-789456"
    And the account has an initial balance of 45000.00 USD as of "2024-01-15T08:00:00Z"
    And the following transactions were processed less than 24 hours ago:
      | transaction_id | type        | amount   | timestamp             | status    |
      | TXN-001       | contribution | 500.00   | 2024-01-15T14:30:00Z | pending   |
      | TXN-002       | contribution | 1000.00  | 2024-01-15T16:45:00Z | pending   |
      | TXN-003       | withdrawal   | 200.00   | 2024-01-15T18:20:00Z | pending   |
    When the participant requests their account balance at "2024-01-15T20:00:00Z"
    Then the account balance should not include pending transactions
    And the displayed balance should be 45000.00 USD
    And the response should include a warning message "Recent transactions are still processing and not reflected in this balance"
    And the response should list 3 pending transactions
    And the total pending amount should be 1300.00 USD
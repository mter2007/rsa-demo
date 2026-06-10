Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  @SRADEMO-258
  Scenario: Active session under 15 minutes - Negative
    Given the participant "john.doe@example.com" is logged into the account service
    And the participant has an active session that started 10 minutes ago
    And the participant has a retirement account "RET-401K-98765" with balance 125000.00
    When the participant attempts to view their retirement account balance
    Then the account balance should not be displayed
    And the participant should see an error message "Session expired. Please log in again."
    And the participant should be redirected to the login page
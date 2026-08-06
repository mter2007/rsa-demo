Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  @SRADEMO-258
  Scenario: Re-authentication after session timeout
    Given participant "john.doe@example.com" is logged into the account service
    And participant has an active session with ID "sess_7f8a9b2c"
    And the session timeout is configured to 30 minutes
    And participant has a retirement account "401K-8472951" with balance 125000.00
    When participant views their retirement account balance at 10:00 AM
    Then the account balance of 125000.00 is displayed successfully
    When 30 minutes pass and the session expires
    And participant attempts to view their retirement account balance again
    Then the system returns status code 401
    And the system displays message "Your session has expired. Please log in again."
    And participant is redirected to the login page
    When participant re-authenticates with username "john.doe@example.com" and password "SecurePass123!"
    And participant creates a new session with ID "sess_4d3e2f1a"
    And participant views their retirement account balance
    Then the system returns status code 200
    And the account balance of 125000.00 is displayed successfully
    And participant session "sess_4d3e2f1a" is active
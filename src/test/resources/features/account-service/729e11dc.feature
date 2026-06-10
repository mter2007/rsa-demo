@SRADEMO-258
Feature: Retirement Account Balance Viewing
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  Scenario: Participant is prompted to re-authenticate after 15 minutes of idle session before balance is displayed
    Given participant "John Smith" with account number "ACC-789456123" is authenticated
    And the participant has a retirement account balance of "$125,750.00"
    And the participant has been idle for "15" minutes
    When the participant attempts to view their retirement account balance
    Then the participant is prompted to re-authenticate
    And the retirement account balance is not displayed
    When the participant successfully re-authenticates with username "john.smith@email.com" and password "SecurePass123!"
    Then the participant sees their retirement account balance of "$125,750.00"
    And the session is renewed with a new expiration time
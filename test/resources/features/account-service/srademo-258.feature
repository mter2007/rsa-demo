```gherkin
Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So that I can monitor my account holdings and investment performance
  
  Component: account-service
  Story: SRADEMO-258

  Scenario: Display account balance on Account Summary page (Positive)
    Given the participant is authenticated in the TIAA portal
    And the participant has an active retirement account with a balance of $50,000.00
    When the participant navigates to the Account Summary page
    Then the participant should see their current total account balance displayed as "$50,000.00"
    And the balance should include all transactions processed as of the last end-of-day NAV calculation
    And the balance should display a breakdown showing each investment fund name with its corresponding value

  Scenario: Display account balance when not authenticated (Negative)
    Given the participant is not authenticated in the TIAA portal
    When the participant attempts to navigate to the Account Summary page
    Then the participant should be redirected to the login page
    And no account balance information should be displayed

  Scenario: Display account balance with pending transactions within 24 hours (Edge)
    Given the participant is authenticated in the TIAA portal
    And the participant has a transaction processed 12 hours ago
    When the participant navigates to the Account Summary page
    Then the participant should see their account balance
    And the balance should reflect all transactions processed up to the most recent end-of-day NAV calculation
    And a timestamp displaying "Balance as of [date/time]" should be shown

  Scenario: Balance matches official NAV after 24 hours (Positive)
    Given the participant is authenticated and viewing the Account Summary page
    And the last transaction was processed 25 hours ago
    When the participant refreshes the Account Summary page
    Then the balance displayed should match the official end-of-day NAV price
    And no pending transaction warnings should be displayed

  Scenario: Balance with recent transaction under 24 hours (Negative)
    Given the participant is authenticated and viewing the Account Summary page
    And the last transaction was processed 6 hours ago
    When the participant views the balance
    Then the balance may not yet reflect the most recent official end-of-day NAV
    And a timestamp indicating "Balance as of [date/time]" should be displayed

  Scenario: Balance accuracy at exactly 24 hours (Edge)
    Given the participant is authenticated and viewing the Account Summary page
    And the last transaction was processed exactly 24 hours ago
    When the participant views the balance
    Then the balance displayed should match the official end-of-day NAV price
    And a timestamp indicating "Balance as of [date/time]" should be displayed

  Scenario: View detailed fund holdings (Positive)
    Given the participant is authenticated and viewing the Account Summary page
    And the account has holdings of 100 units in "TIAA Growth Fund" valued at $10,000.00
    When the participant clicks on "TIAA Growth Fund"
    Then the participant should see detailed holdings for that fund
    And the details should include "100.000" as the number of units held
    And the details should include "$100.0000" as the current unit price
    And the details should include "$10,000.00" as the total value

  Scenario: Attempt to view details for fund with zero holdings (Negative)
    Given the participant is authenticated and viewing the Account Summary page
    And "TIAA Bond Fund" is displayed with zero holdings
    When the participant clicks on "TIAA Bond Fund"
    Then the participant should see a message "No holdings available for this fund"
    And no unit, unit price, or total value details should be displayed

  Scenario: View details for fund with fractional units (Edge)
    Given the participant is authenticated and viewing the Account Summary page
    And the account has holdings of 123.456 units in "TIAA Equity Fund"
    When the participant clicks on "TIAA Equity Fund"
    Then the participant should see "123.456" as the number of units displayed to at least 3 decimal places
    And the unit price should be displayed as "$45.6789" to at least 4 decimal places
    And the total value should be displayed as "$5,641.21" with exactly 2 decimal places

  Scenario: Session timeout at 15 minutes prompts re-authentication (Positive)
    Given the participant is authenticated and on the Account Summary page
    And the participant's session has been idle for exactly 15 minutes
    When the session timeout threshold is reached
    Then the participant should be prompted with a re-authentication dialog
    And the account balance should be masked or hidden until re-authentication is complete

  Scenario: Active session under 15 minutes remains visible (Negative)
    Given the participant is authenticated and on the Account Summary page
    And the participant's session has been idle for 14 minutes
    When the participant views the page
    Then no re-authentication prompt should be displayed
    And the account balance should remain visible

  Scenario: Re-authentication after session timeout exceeds 15 minutes (Edge)
    Given the participant is authenticated and on the Account Summary page
    And the participant's session has been idle for 16 minutes
    When the participant is prompted to re-authenticate
    And the participant successfully re-authenticates with valid credentials
    Then the account balance should be displayed without requiring page navigation
    And the balance should reflect the most current data available

  Scenario: Display zero balance account (Positive)
    Given the participant is authenticated in the TIAA portal
    And the participant has a retirement account with a balance of $0.00
    When the participant navigates to the Account Summary page
    Then the participant should see a message "No holdings found"
    And no fund breakdown should be displayed
    And the total account balance section should display the message "No holdings found" instead of "$0.00"

  Scenario: Display account with minimal non-zero balance (Negative)
    Given the participant is authenticated in the TIAA portal
    And the participant has a retirement account with a balance of $0.01
    When the participant navigates to the Account Summary page
    Then the participant should see their account balance displayed as "$0.01"
    And the fund breakdown should be visible
    And the message "No holdings found" should not be displayed

  Scenario: Account transitions from zero to non-zero balance (Edge)
    Given the participant is authenticated and viewing the Account Summary page
    And the account currently displays "No holdings found" due to $0.00 balance
    When a transaction is processed that increases the balance to $100.00
    And the participant refreshes the Account Summary page
    Then the "No holdings found" message should no longer be displayed
    And the participant should see their current account balance as "$100.00"
    And the fund breakdown should be visible
```
```gherkin
Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance on the Account Summary page
  So that I can monitor my retirement savings and investment performance

  Background:
    Given the account-service is available

  @positive
  Scenario: Display account balance on Account Summary page (Positive)
    Given the participant is authenticated in the TIAA portal
    And the participant has an active retirement account with a non-zero balance
    When the participant navigates to the Account Summary page
    Then the participant should see their current total account balance displayed
    And the balance should include all transactions processed as of the last end-of-day NAV calculation
    And the balance should display a breakdown showing each investment fund name with its corresponding value

  @negative
  Scenario: Display account balance on Account Summary page (Negative)
    Given the participant is not authenticated in the TIAA portal
    When the participant attempts to navigate to the Account Summary page
    Then the participant should be redirected to the login page
    And no account balance information should be displayed

  @edge
  Scenario: Display account balance with pending transactions (Edge)
    Given the participant is authenticated in the TIAA portal
    And the participant has transactions processed within the last 24 hours
    When the participant navigates to the Account Summary page
    Then the participant should see their account balance
    And the balance should reflect all transactions processed up to the most recent end-of-day NAV calculation

  @positive
  Scenario: Balance matches official NAV after 24 hours (Positive)
    Given the participant is viewing the account balance on the Account Summary page
    And the last transaction was processed more than 24 hours ago
    When the participant refreshes the Account Summary page
    Then the balance displayed should match the official end-of-day NAV price
    And no pending transaction warnings should be displayed

  @negative
  Scenario: Balance with recent transactions under 24 hours (Negative)
    Given the participant is viewing the account balance on the Account Summary page
    And the last transaction was processed less than 24 hours ago
    When the participant views the balance
    Then the balance may not yet reflect the most recent official end-of-day NAV
    And a timestamp indicating "Balance as of [date/time]" should be displayed

  @edge
  Scenario: Balance accuracy at exactly 24 hours (Edge)
    Given the participant is viewing the account balance on the Account Summary page
    And the last transaction was processed exactly 24 hours ago
    When the participant views the balance
    Then the balance displayed should match the official end-of-day NAV price

  @positive
  Scenario: View detailed fund holdings (Positive)
    Given the participant is viewing the account balance on the Account Summary page
    And the account has holdings in at least one investment fund
    When the participant clicks on a fund name
    Then the participant should see detailed holdings for that fund
    And the details should include the number of units held
    And the details should include the current unit price
    And the details should include the total value calculated as (units × unit price)

  @negative
  Scenario: Attempt to view details for fund with no holdings (Negative)
    Given the participant is viewing the account balance on the Account Summary page
    And a fund is displayed with zero holdings
    When the participant clicks on that fund name
    Then the participant should see a message "No holdings available for this fund"
    And no unit, unit price, or total value details should be displayed

  @edge
  Scenario: View details for fund with fractional units (Edge)
    Given the participant is viewing the account balance on the Account Summary page
    And the account has holdings with fractional units (e.g., 123.456 units)
    When the participant clicks on that fund name
    Then the participant should see the number of units displayed to at least 3 decimal places
    And the unit price should be displayed to at least 4 decimal places
    And the total value should be calculated and displayed with 2 decimal places

  @positive
  Scenario: Session timeout prompts re-authentication (Positive)
    Given the participant is authenticated and on the Account Summary page
    And the participant's session has been idle for exactly 15 minutes
    When the session timeout threshold is reached
    Then the participant should be prompted with a re-authentication dialog
    And the account balance should be masked or hidden until re-authentication is complete

  @negative
  Scenario: Active session under 15 minutes (Negative)
    Given the participant is authenticated and on the Account Summary page
    And the participant's session has been idle for 14 minutes
    When the participant views the page
    Then no re-authentication prompt should be displayed
    And the account balance should remain visible

  @edge
  Scenario: Re-authentication after session timeout (Edge)
    Given the participant is on the Account Summary page
    And the participant's session has been idle for 16 minutes
    When the participant is prompted to re-authenticate
    And the participant successfully re-authenticates
    Then the account balance should be displayed without requiring page navigation
    And the balance should reflect the most current data available

  @positive @edge
  Scenario: Display zero balance account (Positive - Edge Case)
    Given the participant is authenticated in the TIAA portal
    And the participant has a retirement account with a zero balance
    When the participant navigates to the Account Summary page
    Then the participant should see a message "No holdings found"
    And no fund breakdown should be displayed
    And the total account balance section should display the message instead of "$0.00"

  @negative
  Scenario: Display account with minimal non-zero balance (Negative)
    Given the participant is authenticated in the TIAA portal
    And the participant has a retirement account with a balance of $0.01
    When the participant navigates to the Account Summary page
    Then the participant should see their account balance displayed as "$0.01"
    And the fund breakdown should be visible
    And the message "No holdings found" should not be displayed

  @edge
  Scenario: Account transitions from zero to non-zero balance (Edge)
    Given the participant is viewing the Account Summary page
    And the account currently displays "No holdings found" due to zero balance
    When a transaction is processed that increases the balance above zero
    And the participant refreshes the Account Summary page
    Then the "No holdings found" message should no longer be displayed
    And the participant should see their current account balance with fund breakdown
```
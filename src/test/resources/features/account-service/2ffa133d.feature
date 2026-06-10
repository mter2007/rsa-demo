Feature: View Retirement Account Balance
  As a participant
  I want to view my retirement account balance
  So I can track my savings progress

  @SRADEMO-258
  Scenario: Display zero balance account
    Given I am a registered participant with account number "ACC-7890123"
    And my retirement account has a balance of 0.00 USD
    And my account was opened on "2024-01-15"
    When I request my account balance details
    Then I should see my account number as "ACC-7890123"
    And I should see my current balance as 0.00 USD
    And I should see my account status as "Active"
    And I should see my account opening date as "2024-01-15"
Feature: Consumer Rights feature

  Scenario: Open consumer rights act 2015
    Given a user goes to consumer rights
    When they click on "Discover Consumer Rights Act 2015"
    Then page title should be "Consumer Rights Act 2015 - Which?"

  Scenario: Check latest news exist
    Given a user goes to consumer rights
    When they click on the latest entry in news
    Then page title should be containing "Which? News"

  Scenario Outline: Search for actions by full action name
    Given a user goes to consumer rights
    When they Search for <search_query>
    Then user should be displayed with search results
    And the first action should be emphasized <search_query>

  Examples:
    |search_query|
    |Letter to get a refund if your item is faulty|
    |Letter to refuse paying the cost of returning a faulty item|
    |How do I cancel an online order|

  Scenario Outline: Search for regulation by partial text
    Given a user goes to consumer rights
    When they Search for <partial_query>
    Then user should be displayed with search results
    And the first regulation should be <partial_query>

  Examples:
  |partial_query|
  |Sale of|
  |Distance Selling|
  |Payment Services|

  Scenario Outline: Searching with special chars
    Given a user goes to consumer rights
    When they Search for <special_query>
    Then user should not brake the webpage



  Examples:
  |special_query|
  |^|
  |@|
  |$|
  |%|
    #note that on the percentage search the application throws exception.


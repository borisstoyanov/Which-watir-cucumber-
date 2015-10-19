require 'rubygems'
require 'watir'
require 'watir-webdriver'
require 'cucumber'

search_term = nil
title = nil

Before do
  @browser = Watir::Browser.new :ff
end

After do
  @browser.close
end

Given(/^a user goes to consumer rights$/) do
  @browser.goto 'http://www.which.co.uk/consumer-rights'
end

When(/^they click on "([^"]*)"$/) do |arg|
  search_term = arg
  @browser.link(:text => search_term).click()
end

Then(/^page title should be "([^"]*)"$/) do |arg|
  title = arg
  @browser.title == title
end

Then(/^user should be displayed with search results$/) do
  @browser.ul(:class => 'search-results').exist?
end

When(/^they Search for (.*)$/) do |search_query|
  search_term = search_query
  @browser.text_field(:id =>'searchQuery').send_keys(search_term)
  @browser.button(:id =>'searchSubmit').click
end

And(/^the first action should be emphasized (.*)$/) do |search_query|
  search_term = search_query
  @browser.em(:xpath, "//ul[@class='search-results']/li//em[text()='" + search_term + "']").exist?
end

And(/^the first regulation should be (.*)$/) do |partial_query|
  search_term = partial_query
  @browser.a(:xpath, "//li[@class='regulation']/h5//a[contains(text(),'" + search_term + "')]").exist?
end

Then(/^user should not brake the webpage$/) do
  @browser.text.should =~ /No results found for/
end


When(/^they click on the latest entry in news$/) do
  @browser.a(:xpath, "//article[@class='newsBlock block']//h4//a").click
end

Then(/^page title should be containing (.*)$/) do |arg|
  title = arg
  @browser.title.include? title
end
require 'rubygems'
require 'watir'
require 'watir-webdriver'
require 'cucumber'
require './page_objects/page_objects'

search_term = nil
title = nil
URL = 'http://www.which.co.uk/consumer-rights'

Before do
  @site = Site.new(Watir::Browser.new)
end

After do
  @site.close
end

Given(/^a user goes to consumer rights$/) do
  @consumer = @site.consumer_rights.goTo
end

When(/^they click on "([^"]*)"$/) do |arg|
  search_term = arg
  @consumer.click_link(search_term)
end

Then(/^page title should be "([^"]*)"$/) do |arg|
  title = arg
  @consumer.isAt(title)
end

Then(/^user should be displayed with search results$/) do
  xpath = "//ul[@class='search-results']"
  @consumer.element_present(xpath)
end

When(/^they Search for (.*)$/) do |search_query|
  search_term = search_query
  @consumer.search(search_query)
end

And(/^the first action should be emphasized (.*)$/) do |search_query|
  element = "//ul[@class='search-results']/li//em[text()='" + search_query + "']"
  @consumer.element_present(element)
end

And(/^the first regulation should be (.*)$/) do |partial_query|
  element = "//li[@class='regulation']/h5//a[contains(text(),'" + partial_query + "')]"
  @consumer.element_present(element)
end

Then(/^user should not brake the webpage$/) do
  @consumer.text_exist? 'No results found for'
end

When(/^they click on the latest entry in news$/) do
  @news = @consumer.click_on_latest_entry_in_news
end

Then(/^page title should be containing (.*)$/) do |arg|
  @news.isAt arg
end


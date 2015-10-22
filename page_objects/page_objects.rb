require 'rubygems'
require 'watir'
require 'watir-webdriver'
require 'cucumber'


class MyBrowser
  def initialize(browser)
    @browser = browser
  end
end

class Site < MyBrowser
  def consumer_rights
    @consumer_rights = Consumer_rights.new(@browser)
    @consumer_rights
  end

  def news
    @news = nil
  end

  def close
    @browser.close
  end
end

class News < MyBrowser
  def isAt(title)
    @browser.title.include? title
  end
end

class Consumer_rights < MyBrowser
  URL = 'http://www.which.co.uk/consumer-rights'

  def goTo
    @browser.goto URL
    self
  end

  def isAt
    @browser.title.include? 'Consumer Rights - Which?'
  end

  def isAt(title)
    @browser.title.include? title
  end

  def close
    @browser.close
  end

  def click_link(element)
    @browser.link(:text => element).click()
  end

  def click_byXpath(xpath)
    @browser.element(:xpath, xpath).click
  end

  def element_present(xpath)
    @browser.element(:xpath, xpath).exist?
  end

  def search(term)
    @browser.text_field(:id =>'searchQuery').send_keys(term)
    @browser.button(:id =>'searchSubmit').click
  end

  def text_exist?(text)
    @browser.text.include?(text).should == true
  end

  def click_on_latest_entry_in_news
    click_byXpath("//article[@class='newsBlock block']//h4//a")
    News.new(@browser)
  end


end
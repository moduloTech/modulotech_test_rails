require "test_helper"
require 'selenium/webdriver'


Capybara.register_driver :headless_firefox do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.headless!

  Capybara::Selenium::Driver.new app,
                                 browser: :firefox,
                                 options: options
end

Capybara.javascript_driver = :headless_firefox

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_firefox, screen_size: [1400, 1400]
end


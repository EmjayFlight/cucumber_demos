require 'capybara/cucumber'

#Capybara.register_driver :selenium do |app|
#  Capybara::Selenium::Driver.new(app, :browser => :chrome)
#end

Capybara.default_driver = :selenium

capyDrive = Capybara.current_session.driver.browser
window = capyDrive.manage.window
wait = Selenium::WebDriver::Wait.new ignore: Selenium::WebDriver::Error::NoAlertPresentError

Given(/^that I'm on Dan's Site$/) do
  visit('https://still-everglades-45219.herokuapp.com/')
  window.resize_to(1280, 720)
end

When(/^I select a file$/) do
  attach_file("the-file" , File.expand_path('/Users/matthewjohnson/Documents/Projects/404projects/urlFiles.txt'))
end

When(/^click "([^"]*)"$/) do |arg1|
  click_button('Upload')
end

Then(/^I should get a file size returned$/) do
	wait.until { page.driver.browser.switch_to.alert } #ensures that script waits until the popup opens to switch to popup
	expect(capyDrive.switch_to.alert.text[0,9]).to eq "File size"
end
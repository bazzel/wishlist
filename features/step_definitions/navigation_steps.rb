# frozen_string_literal: true

Given('I open the application') do
  visit '/'
end

Given('I am on the Sign in page') do
  visit '/sign_in'
end

When('I navigate to the welcome page') do
  visit '/welcome'
end

Then("I'm being redirected to the sign in page") do
  step 'I see the sign in page'
end

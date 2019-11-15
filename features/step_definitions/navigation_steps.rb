# frozen_string_literal: true

Given('I open the application') do
  visit '/'
end

Given('I am on the Sign in page') do
  visit '/sign_in'
end

When('I click( the) {string}( button)') do |label|
  click_on label
end

When('I navigate to the events page') do
  visit '/events'
end

Then("I'm being redirected to the sign in page") do
  step 'I see the sign in page'
end

When('I use the magic link') do
  @user = User.last
  visit token_sign_in_path(@user.login_token)
end

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

When('I click the card for event {string}') do |event_title|
  find('.card', text: event_title).click
  @current_event = Event.find_by(title: event_title)
end

When('I click the thumbtack button') do
  wait 0.1
  find('a i.fas.fa-thumbtack').click
end

Given('I open the article list for {string}') do |event_title|
  step 'I open the application'
  step %(I click the card for event "#{event_title}")
end

Then("I'm being redirected to the sign in page") do
  step 'I see the sign in page'
end

When('I use the magic link') do
  @user = User.last
  visit token_sign_in_path(@user.login_token)
end

When('I choose {string} from the {string} menu') do |submenu, menu|
  click_on(menu)
  click_on(submenu)
end

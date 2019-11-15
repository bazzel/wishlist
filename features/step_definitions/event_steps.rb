# frozen_string_literal: true

Then('I am seeing a page for adding a new event') do
  expect(current_path).to eql('/events/new')
  expect(page).to have_content('Een nieuwe afspraak maken')

  within('form') do
    expect(page).to have_button('Opslaan')
  end
end

Given('I am adding a new event') do
  step 'I signed in'
  step 'I click the "add" button'
end

Then(/I am( not)? seeing the button for adding a new event/) do |negate|
  have_add_button = have_link('add')
  negate ? expect(page).not_to(have_add_button) : expect(page).to(have_add_button)
end

Then('I am viewing the event') do
  event = Event.last

  expect(current_path).to eql(event_path(event))
  expect(page).to have_content(event.title)

  expect(page).to have_content('1 gast')
  expect(page).to have_content(@current_user_email)
end

Then('I can edit the event') do
  click_on('more_vert')
  expect(page).to have_link('Edit')
end

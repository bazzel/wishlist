# frozen_string_literal: true

Given('I am adding a new event') do
  step 'I signed in'
  step 'I click the "add" button'
end

Given('I have created the following events:') do |table|
  current_user = User.find_by(email: @current_user_email)

  table.hashes.each do |hash|
    create(:event, hash.merge(users: [current_user]))
  end
end

Then('I am seeing a page for adding a new event') do
  expect(current_path).to eql('/events/new')
  expect(page).to have_content('Een nieuwe afspraak maken')

  within('form') do
    expect(page).to have_button('Opslaan')
  end
end

Then("I am seeing a page for editing the event") do
  expect(current_path).to match(/\/events\/.*\/edit/)

  within('form') do
    expect(page).to have_button('Opslaan')
  end
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

Then('I see a page with {int} event(s)') do |items_count|
  within('.list-group') do
    expect(page).to have_css('.list-group-item', count: items_count)
  end
end

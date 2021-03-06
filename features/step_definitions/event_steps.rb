# frozen_string_literal: true

Given('I am adding a new event') do
  step 'I signed in'
  step 'I click the "add" button'
end

Given('I have created the following events:') do |table|
  current_user = User.find_by(email: @current_user_email)

  table.hashes.each do |hash|
    guest_emails = (hash[:guest_emails]).to_s.split(/,\s*/)
    hash[:guest_emails] = (guest_emails << current_user.email).join(', ')
    create(:event, hash)
  end
end

Given('I click {string} for event {string}') do |label, title|
  within('.card', text: title) do
    click_on 'more_vert'
    click_on label
  end

  @current_event = Event.find_by(title: title)
end

Then('I am seeing a page for adding a new event') do
  expect(current_path).to eql('/events/new')
  expect(page).to have_content('Een nieuwe afspraak maken')

  within('form') do
    expect(page).to have_button('Opslaan')
  end
end

Then('I am seeing a page for editing the event') do
  expect(current_path).to match(%r{/events/.*/edit})

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

  expect(current_path).to eql(event_articles_path(event))
  expect(page).to have_content(event.title)
  expect(page).to have_content(@current_user_email)
end

Then('I can edit the event') do
  click_on('more_vert')
  expect(page).to have_link('Bewerken')
end

Then('I see a page with {int} event(s)') do |items_count|
  if items_count.nonzero?
    within('.card-columns') do
      expect(page).to have_css('.card', count: items_count)
    end
  else
    expect(page).not_to have_css('.card-columns')
  end
end

Then('I am seeing a page with {int} guest(s)') do |_items_count|
  @current_event.guests.each do |guest|
    expect(page).to have_content(guest.email)
  end
end

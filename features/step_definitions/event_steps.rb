# frozen_string_literal: true

Then('I am seeing a page for adding a new event') do
  expect(current_path).to eql('/events/new')
  expect(page).to have_content('Een nieuwe afspraak maken')

  within('form') do
    expect(page).to have_button('Opslaan')
  end
end

Then(/I am( not)? seeing the button for adding a new event/) do |negate|
  have_add_button = have_link('add')
  negate ? expect(page).not_to(have_add_button) : expect(page).to(have_add_button)
end

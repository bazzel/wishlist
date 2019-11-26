# frozen_string_literal: true

Then("I'm in") do
  expect(current_path).to eql('/')

  within('nav') do
    expect(page).to have_text(@user.email)
  end

  # expect(page).to have_link('add')
end

Then("I'm out") do
  step 'I am on the Sign in page'

  # expect(page).to have_text('Je bent nu afgemeld.')
  expect(page).not_to have_button('add')
end

When('I expand the panel for {string}') do |title|
  find('.expansion-panel', text: title).click
end

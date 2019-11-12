# frozen_string_literal: true

Then("I'm in") do
  expect(current_path).to eql('/')

  within('nav') do
    expect(page).to have_text(@user.email)
  end

  # expect(page).to have_link('add')
end

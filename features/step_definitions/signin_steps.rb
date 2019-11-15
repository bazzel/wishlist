# frozen_string_literal: true

Given('I signed in with my email address {string}') do |email|
  step 'I am on the Sign in page'
  step %(I sign up with my email address "#{email}")
  step 'I use the magic link'
end

Given('I signed in') do
  step 'I signed in with my email address "john.doe@example.org"'
end

When('I sign up with my email address {string}') do |email|
  fill_in('user[email]', with: email)
  click_on 'Aanmelden'
end

When('I sign up without an email address') do
  step 'I sign up with my email address ""'
end

When('I sign out') do
  within('nav') do
    click_on @user.email
    click_on 'Afmelden'
  end
end

Then('I see a page with instructions for {string} how to login') do |email|
  expect(page).to have_text('Controleer je e-mail')
  expect(page).to have_text("We hebben een speciale link gemaild naar #{email}. Klik op de link in de e-mail om van start te kunnen gaan.") # rubocop:disable Metrics/LineLength
end

Then('I see the sign in page') do
  expect(current_path).to eql('/sign_in')
  expect(page).not_to have_css('nav')
  expect(page).to have_css('h1', text: 'Aanmelden bij Wishlist')
  expect(page).to have_field('user[email]')
  expect(page).to have_button('Aanmelden')
end

Then('I see an error telling me an email address is required') do
  expect(current_path).to eql('/sign_in')
  expect(page).to have_text('Email moet opgegeven zijn')
end

Then('I see an error telling me I have entered an invalid email address') do
  expect(current_path).to eql('/sign_in')
  expect(page).to have_text('Email is geen geldig e-mailadres')
end

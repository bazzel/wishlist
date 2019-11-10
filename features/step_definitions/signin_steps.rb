# frozen_string_literal: true

Then('I see the sign in page') do
  expect(current_path).to eql('/sign_in')
  expect(page).not_to have_css('nav')
  expect(page).to have_css('h1', text: 'Aanmelden bij Wishlist')
  expect(page).to have_field('user[email]')
  expect(page).to have_button('Aanmelden')
end

When('I sign up with my email address {string}') do |email|
  fill_in('user[email]', with: email)
  click_on 'Aanmelden'
end

Then('I see a page with instructions for {string} how to login') do |email|
  expect(page).to have_text('Controleer je e-mail')
  expect(page).to have_text("We hebben een speciale link gemaild naar #{email}. Klik op de link in de e-mail om van start te kunnen gaan.")
end

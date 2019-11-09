Then("I see the sign in page") do
  expect(current_path).to eql('/sign_in')
  expect(page).not_to have_css('nav')
  expect(page).to have_css('h1', text: 'Aanmelden bij Wishlist')
  expect(page).to have_field('user[email]')
  expect(page).to have_button('Aanmelden')
end

Then("I see the sign in page") do
  expect(current_path).to eql('/sign_in')
  expect(page).not_to have_css('nav')
  expect(page).to have_text('Log eenvoudig in met je e-mailadres')
  expect(page).to have_field('Email')
  expect(page).to have_button('Meld aan')
end

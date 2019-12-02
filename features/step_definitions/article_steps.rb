# frozen_string_literal: true

Then('I am seeing a modal for adding a new article') do
  expect(current_path).to match(%r{/events/#{@current_event.slug}/articles})
  expect(page).to have_css('#newArticle.modal', visible: true)
end

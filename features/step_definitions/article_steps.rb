# frozen_string_literal: true

Then('I am seeing a page for adding a new article') do
  expect(current_path).to match(%r{/events/#{@current_event.slug}/articles/new})
end

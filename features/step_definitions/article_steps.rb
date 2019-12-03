# frozen_string_literal: true

Given("I am adding a new article for {string}") do |event_title|
  step %Q(I open the article list for "#{event_title}")
  step %Q(I click the "add" button)
  step %Q(I click the "add_shopping_cart" button)
end

Then('I am seeing a modal for adding a new article') do
  expect(current_path).to match(%r{/events/#{@current_event.slug}/articles})
  expect(page).to have_css('#newArticle.modal', visible: true)
end


Then("I am having {int} article(s)") do |articles_count|
  # TODO: make this more specific
  expect(page).to have_css('.list-group-item', count: articles_count)
end

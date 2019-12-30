# frozen_string_literal: true

Given('I am adding a new article for {string}') do |event_title|
  step %(I open the article list for "#{event_title}")
  step %(I click the "add" button)
  step %(I click the "add_shopping_cart" button)
end

Given('I have created the following articles:') do |table|
  current_user = User.find_by(email: @current_user_email)

  table.hashes.each do |hash|
    event = Event.find_or_create_by(title: hash.delete('event'))

    unless event.invited?(current_user)
      event.users << current_user
      event.save
    end

    guest = event.guests.find_by(user: current_user)

    hash[:guest] = guest
    create(:article, hash)
  end
end

Given("the following articles:") do |table|
  table.hashes.each do |hash|
    event        = Event.find_by(title: hash.delete('event'))
    user         = User.find_by(email: hash.delete('guest_email'))
    guest        = event.guests.find_by(user: user)
    hash[:guest] = guest

    create(:article, hash)
  end
end

Given('I hover over the article {string}') do |article_title|
  find('.list-group-item', text: article_title).hover
end

Then("I should have claimed article {string}") do |article_title|
  within('.list-group-item', text: article_title) do
    expect(page).to have_css('i.material-icons', text: 'gavel')
  end
end

Then('I am seeing a modal for adding a new article') do
  expect(current_path).to match(%r{/events/#{@current_event.slug}/articles})
  step %(I see a modal with "Een nieuw artikel toevoegen" as title)
end

Then('I should see {int} article(s)') do |articles_count|
  # TODO: make this more specific
  expect(page).to have_css('.list-group-item', count: articles_count)
end

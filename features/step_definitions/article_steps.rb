# frozen_string_literal: true

Given('I am adding a new article for {string}') do |event_title|
  step %(I open the article list for "#{event_title}")
  step %(I click the "add" button)
  step %(I click the "add_shopping_cart" button)
end

Given('I have created the following article(s):') do |table|
  current_user = User.find_by(email: @current_user_email)

  table.hashes.each do |hash|
    event = Event.find_or_create_by(title: hash.delete('event'))

    unless event.invited?(current_user)
      event.users << current_user
      event.save
    end

    hash['guest']    = event.guests.find_by(user: current_user)
    claimant_email   = hash.delete('claimant_email')
    claimant         = event.guests.find_by(user: User.find_by(email: claimant_email))
    hash['claimant'] = claimant

    create(:article, hash)
  end
end

Given('the following articles:') do |table|
  table.hashes.each do |hash|
    event            = Event.find_by(title: hash.delete('event'))
    guest_email      = hash.delete('guest_email')
    guest            = event.guests.find_by(user: User.find_by(email: guest_email))
    hash['guest']    = guest
    claimant_email   = hash.delete('claimant_email')
    claimant         = event.guests.find_by(user: User.find_by(email: claimant_email))
    hash['claimant'] = claimant

    create(:article, hash)
  end
end

Given('I hover over the article {string}') do |article_title|
  find('.list-group-item', text: article_title).hover
end

Then('I should have claimed article {string}') do |_article_title|
  expect(page).to have_css('a.visible i.fas.fa-thumbtack')
end

Then('I should not have claimed article {string}') do |_article_title|
  expect(page).not_to have_css('a.visible i.fas.fa-thumbtack')
end

Then('I am seeing a modal for adding a new article') do
  expect(current_path).to match(%r{/events/#{@current_event.slug}/articles})
  step %(I see a modal with "Een nieuw artikel toevoegen" as title)
end

Then('I should see {int} article(s)') do |articles_count|
  # TODO: make this more specific
  expect(page).to have_css('.list-group-item', count: articles_count)
end

Given('I have claimed the article {string}') do |article_title|
  step %(I hover over the article "#{article_title}")
  step %(I click the thumbtack button)
end

Then('I should be able to claim the article {string}') do |article_title|
  step %(I hover over the article "#{article_title}")

  within('.list-group-item', text: article_title) do
    expect(page).to have_css('a:not(.visible) i.fas.fa-thumbtack')
  end
end

Then('I should not be able to claim the article {string}') do |article_title|
  step %(I hover over the article "#{article_title}")

  within('.list-group-item', text: article_title) do
    expect(page).not_to have_css('a:not(.active) i.material-icons', text: 'gavel')
    expect(page).not_to have_css('a.active i.material-icons', text: 'gavel')
  end
end

Then('I should see that article {string} is disabled') do |article_title|
  within('.list-group-item', text: article_title) do
    expect(page).to have_css('.text-muted')
  end
end

Then('I should not see that article {string} is disabled') do |article_title|
  within('.list-group-item', text: article_title) do
    expect(page).not_to have_css('.text-muted')
  end
end

# frozen_string_literal: true

Given('I fill in {string} with {string}') do |label, value|
  label_to_placeholder_mapping = {
    'Titel' => 'event_title'
  }

  fill_in label_to_placeholder_mapping[label], with: value
end

When('I add {string} as guest') do |text|
  el = find('.tagify__input')
  el.set("#{text}\n")
  el.send_keys(:enter)
end

When('I remove {string} as guest') do |text|
  el = find('.event_guest_emails tag', text: text)
  el.find('x').click
  sleep 0.5
end

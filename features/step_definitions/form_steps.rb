# frozen_string_literal: true

Given('I fill in {string} with {string}') do |locator, value|
  fill_in locator, with: value
end

When('I add {string} as guest') do |text|
  el = find('.tagify__input')
  el.set("#{text}\n")
  el.send_keys(:enter)
end

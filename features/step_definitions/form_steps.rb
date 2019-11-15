# frozen_string_literal: true

Given('I fill in {string} with {string}') do |locator, value|
  fill_in locator, with: value
end

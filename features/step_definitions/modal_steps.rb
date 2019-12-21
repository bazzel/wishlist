# frozen_string_literal: true

Then('I see a modal with {string} as title') do |title|
  within('.modal') do
    expect(page).to have_css('.modal-header h5.modal-title', text: title)
  end
end

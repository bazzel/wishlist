# frozen_string_literal: true

# Helpers that prepare Capybara to work with Selenium.
module JsWorld
  def scroll_to(element)
    script = <<-JS
      arguments[0].scrollIntoView(true);
    JS

    Capybara.current_session.driver.browser.execute_script(script, element.native)
  end
end

World(JsWorld)

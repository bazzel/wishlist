# frozen_string_literal: true

module Material
  # Snackbars provide brief feedback about an operation
  # through a message at the bottom of the screen.
  # @see http://daemonite.github.io/material/docs/4.1/material/snackbars/
  #
  # Make sure you have Stimulus setup and
  # a controller named `snackbar'
  # @see app/javascript/controllers/snackbar_controller.js
  class Snackbar < ActionView::Component::Base
    include BootstrapHelper

    def initialize(flash:, action: nil)
      self.action = action || flash[:action]
      self.flash = flash
    end

    def snackbar_class
      snackbar_class = %w[snackbar]
      snackbar_class << 'snackbar-multi-line' if long_message?
      snackbar_class
    end

    private

    attr_reader :flash, :action

    def action=(value)
      @action = value&.html_safe # rubocop:disable Rails/OutputSafety
    end

    def flash=(value)
      value.delete(:action)
      @flash = value
    end

    def message
      flash.map { |_type, msg| msg }.to_sentence
    end

    def long_message?
      message.size > 75
    end

    # Stimulus
    def data_controller
      'snackbar'
    end
  end
end

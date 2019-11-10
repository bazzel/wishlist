# frozen_string_literal: true

#:nodoc:
class ApplicationMailer < ActionMailer::Base
  default from: 'info@wishlist.com'
  layout 'mailer'
end

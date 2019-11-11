# frozen_string_literal: true

#:nodoc:
class User < ApplicationRecord
  def self.valid_with_token(token)
    where(login_token: token)
      .find_by('login_token_valid_until > ?', Time.zone.now)
  end

  def anonymous?
    false
  end

  def invalidate_token
    update!(login_token: nil, login_token_valid_until: 1.year.ago)
  end
end

# frozen_string_literal: true

# This class is created to use the Null Object pattern with a User model.
class NullUser
  def anonymous?
    true
  end

  def id
    nil
  end
end

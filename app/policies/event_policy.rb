# frozen_string_literal: true

#:nodoc:
class EventPolicy < ApplicationPolicy
  #:nodoc:
  class Scope < Scope
    def resolve
      scope.with_guest(user)
    end
  end

  def create?
    identified?
  end

  def show?
    identified?
  end

  private

  def identified?
    user.identified?
  end
end

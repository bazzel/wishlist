# frozen_string_literal: true

#:nodoc:
class EventPolicy < ApplicationPolicy
  #:nodoc:
  class Scope < Scope
    def resolve
      scope.with_user(user)
    end
  end

  def create?
    true
  end

  def show?
    record.has_user?(user)
  end
end

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

  def update?
    record.invited?(user)
  end

  def show?
    record.invited?(user)
  end
end

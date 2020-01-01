# frozen_string_literal: true

#:nodoc:
class ClaimPolicy < ApplicationPolicy
  #:nodoc:
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    !(record.guest.user == user || record.claimant)
  end

  def destroy?
    record.claimed_by?(user)
  end
end

# frozen_string_literal: true

#:nodoc:
class ArticlePolicy < ApplicationPolicy
  #:nodoc:
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    record.guest.user == user
  end

  def create?
    true
  end

  def destroy?
    update?
  end

  def restore?
    update?
  end
end

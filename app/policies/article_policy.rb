# frozen_string_literal: true

#:nodoc:
class ArticlePolicy < ApplicationPolicy
  #:nodoc:
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    true
  end
end

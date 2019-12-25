# frozen_string_literal: true

#:nodoc:
class EventsController < ApplicationController
  before_action :set_event, only: %i[edit update]
  skip_before_action :require_sign_in, only: :show

  after_action :verify_policy_scoped, only: :index

  def index
    @events = policy_scope(Event).decorate
  end

  def new
    @event = authorize Event.new
    @event.users << current_user
  end

  def show
    skip_authorization
    redirect_to event_articles_path(params[:slug])
  end

  def edit; end

  def create
    @event = authorize Event.new(event_params)

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  private

  def set_event
    @event = authorize Event.find_by(slug: params[:slug]).decorate
  end

  def event_params
    params.require(:event).permit(:title, :guest_emails)
  end
end

# frozen_string_literal: true

#:nodoc:
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit]

  def index
    @events = policy_scope(Event)
  end

  def new
    @event = authorize Event.new
    @event.users << current_user
  end

  def show; end

  def edit

  end

  def create
    @event = authorize Event.new(event_params)

    if @event.save
      redirect_to @event
    else
      render :new
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

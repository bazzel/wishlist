# frozen_string_literal: true

#:nodoc:
class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def index; end

  def new
    @event = Event.new
  end

  def show; end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  private

  def set_event
    @event = Event.find_by(slug: params[:slug])
  end

  def event_params
    params.require(:event).permit(:title).merge(users: [current_user])
  end
end

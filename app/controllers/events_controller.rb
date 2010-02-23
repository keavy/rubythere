class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    unless @event.happenings.blank?
      @upcoming = @event.happenings.upcoming
      @past     = @event.happenings.past
    end
  end
  
  def new
    @event = Event.new
  end
end

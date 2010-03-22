class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    unless @event.happenings.blank?
      @upcoming = @event.happenings.upcoming.last
      @past     = @event.happenings.past
    end
  end
  
  def new
    @event = Event.new
  end
  
  def create
    #raise params.to_yaml
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = "Thanks! Your event has been submitted for review"
      redirect_to root_path
    else
    end
  end
end

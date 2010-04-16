class HappeningsController < ApplicationController
  before_filter :find_event
  before_filter :authenticate
  before_filter :check_authorized
  
  def index
    if @event.happenings.blank?
      @happening  = @event.happenings.build
    else
      @happenings = @event.happenings 
    end
  end
  
  def new
    @happening = @event.happenings.build
  end
  
  private
  def find_event
    @event = Event.find(params[:event_id])
  end
  
  def check_authorized
    unless current_user.editor_for?(@event)
      flash[:error] = "You are not authorized to view the page you requested"
      redirect_to account_path
      return false
    end
  end
end

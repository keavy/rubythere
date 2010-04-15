class EventsController < ApplicationController
  before_filter :find_event, :only => [:edit, :update]
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :check_authorized, :only => [:edit, :update]
  
  def show
    @event = Event.approved.find(params[:id])
    
    unless @event.happenings.blank?
      @latest = @event.happenings[0]
      @other  = @event.happenings[1..@event.happenings.size]
    end
  end
  
  def new
    @event = Event.new
  end
  
  def create
    #raise params.to_yaml
    if params[:event][:happenings_attributes]
      params[:event][:happenings_attributes].each do |h|
        unless h[1]["location_id"].blank?
          h[1].delete("location_attributes")
        end
      end
    end
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = "Thanks! Your event has been submitted for review"
      redirect_to root_path
    else
      render :action => :new
    end
  end
  
  def edit
  end
  
  private
  def find_event
    @event = Event.find(params[:id])
  end
  
  def check_authorized
    unless current_user.editor_for?(@event)
      flash[:error] = "You are not authorized to view the page you requested"
      redirect_to account_path
      return false
    end
  end
end

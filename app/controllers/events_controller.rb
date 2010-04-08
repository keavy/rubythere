class EventsController < ApplicationController
  def show
    @event = Event.approved.find(params[:id])
    
    unless @event.happenings.blank?
      @latest = @event.happenings[0]
      @other  = @event.happenings[1..@event.happenings.size]
    end
    
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url
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
end

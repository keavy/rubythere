class HappeningsController < ApplicationController
  before_filter :find_happening, :only => [:edit, :update]
  before_filter :find_event, :except => [:edit, :update]
  
  before_filter :authenticate
  before_filter :check_authorized
  
  #layout 'form'
  
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
  
  def edit
  end
  
  def update
    if @happening.update_attributes(params[:happening])
      flash[:notice] = "Thanks! Where & When updated"
      redirect_to event_path(@event)
    else
      render :action => :edit
    end
  end
  
  def create
    @happening = @event.happenings.build(params[:happening])
    if @happening.save
      flash[:notice] = "Thanks! Where & When updated"
      redirect_to event_path(@event)
    else
      render :action => :new
    end
  end
  
  private
  def find_happening
    @happening = Happening.find(params[:id])
    @event     = Event.find(@happening.event_id)
  end
  
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

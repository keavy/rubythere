class HappeningsController < ApplicationController
  before_filter :find_happening, :only => [:edit, :update]
  before_filter :find_event, :except => [:edit, :update, :map]

  before_filter :authenticate unless Rails.env == 'development'
  before_filter :check_authorized unless Rails.env == 'development'

  cache_sweeper :events_sweeper

  def index
    if @event.happenings.blank?
      @happening  = @event.happenings.build
    else
      @happenings = @event.happenings.reverse
    end
  end

  def new
    @happening = @event.happenings.build
  end

  def edit
  end

  def update
    set_location
    if @happening.update_attributes(params[:happening])
      flash[:notice] = "Thanks! Where & When updated"
      redirect_to event_path(@event)
    else
      render :action => :edit
    end
  end

  def create
    set_location
    @happening = @event.happenings.build(params[:happening])
    if @happening.save
      flash[:notice] = "Thanks! Where & When updated"
      redirect_to event_path(@event)
    else
      render :action => :new
    end
  end

  def map
    unless fragment_exist?("map")
      @happenings = Happening.approved.upcoming
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

  def set_location
    if params['happening']["location_id"].blank?
      location = find_or_create_location(params['happening']['location_attributes'])
      location = location.id unless location.nil?
    else
      location = params['happening']["location_id"]
    end
    params['happening'].delete("location_attributes")
    params['happening']["location_id"] = location
  end

  def find_or_create_location(attributes)
    return nil if attributes.blank?
    city     = attributes['city']
    country  = attributes['country']
    location = Location.find_or_create_by_city_and_country(city, country)
  end
end

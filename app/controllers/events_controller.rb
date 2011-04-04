class EventsController < ApplicationController
  before_filter :find_event, :only => [:edit, :update]
  before_filter :authenticate, :only => [:edit, :update] unless Rails.env == 'development'
  before_filter :check_authorized, :only => [:edit, :update] unless Rails.env == 'development'

  layout :select_layout

  def index
    options = ['attend','speak']
    @focus  = 'attend'

    if params[:focus] && options.include?(params[:focus])
      @focus = params[:focus]
      @content_title = (@focus == 'speak') ? 'to speak at' : 'to attend'
    end

    unless fragment_exist?("events/#{@focus}")
      @happenings = (params[:focus] == 'speak') ? Happening.approved.upcoming.open_for_speakers : Happening.approved.upcoming
    end
  end

  def show
    @event = Event.approved.find(params[:id])

    unless @event.happenings.blank?
      @event.happenings.reverse!
      @latest = @event.happenings[0]
      @other  = @event.happenings[1..@event.happenings.size]
    end
  end

  def new
    @event = Event.new
  end

  def create
    #raise params.to_yaml
    set_location
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

  def update
    #raise params.to_yaml
    set_location

    if @event.update_attributes(params[:event])
      flash[:notice] = "Thanks! Your event has been updated"
      redirect_to event_path(@event)
    else
      render :action => :edit
    end
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

  def select_layout
    if [ 'index' ].include? action_name
       'listings'
     else
       'application'
     end
  end

  def set_location
    if params[:event][:happenings_attributes]
      params[:event][:happenings_attributes].each do |h|
        if h[1]["location_id"].blank?
          location = find_or_create_location(h[1]['location_attributes'])
          location = location.id unless location.nil?
        else
          location = h[1]["location_id"]
        end
        h[1].delete("location_attributes")
        h[1]["location_id"] = location
      end
    end
  end

  def find_or_create_location(attributes)
    return nil if attributes.blank?
    city     = attributes['city']
    country  = attributes['country']
    location = Location.find_or_create_by_city_and_country(city, country)
  end
end

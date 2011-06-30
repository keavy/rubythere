class Admin::EventsController < AdminAreaController
  inherit_resources

  cache_sweeper :events_sweeper, :only => [:create, :update, :destroy]

  def edit
    resource.admin_submitted = true
    edit!
  end

  def new
    resource.admin_submitted = true
    new!
  end

  def create
    set_location
    resource.admin_submitted = true
    if params[:event][:happenings_attributes]
      params[:event][:happenings_attributes].each do |h|
        unless h[1]["location_id"].blank?
          h[1].delete("location_attributes")
        end
      end
    end
    @event = Event.new(params[:event])
    set_admin_approval(@event)
    if @event.save
      flash[:notice] = "Event successfully added"
      redirect_to admin_events_path
    else
      @event.admin_submitted = true
      render :action => :new
    end
  end

  def update
    find_event
    set_location
    set_admin_approval(@event)
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

  def set_admin_approval(event)
    event.approved        = params[:event][:approved]
    event.admin_submitted = true
  end
end

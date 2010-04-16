class Admin::EventsController < AdminAreaController
  resource_controller

  cache_sweeper :events_sweeper

  [create, update].each { |action| action.wants.html {redirect_to admin_events_path} }

  [new_action,create,edit].each { |action| action.before do 
    object.admin_submitted = true 
  end }

  [create,update].each { |action| action.before do 
    object.approved        = params[:event][:approved] 
    object.admin_submitted = true
  end }
  
  def create
    if params[:event][:happenings_attributes]
      params[:event][:happenings_attributes].each do |h|
        unless h[1]["location_id"].blank?
          h[1].delete("location_attributes")
        end
      end
    end
    @event = Event.new(params[:event])
    @event.approved        = params[:event][:approved] 
    @event.admin_submitted = true
    if @event.save
      flash[:notice] = "Event successfully added"
      redirect_to admin_events_path
    else
      @event.admin_submitted = true
      render :action => :new
    end
  end

end

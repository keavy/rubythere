class Admin::EventsController < AdminAreaController
  resource_controller
  
  cache_sweeper :events_sweeper
  
  [create, update].each { |action| action.wants.html {redirect_to admin_events_path} }
  
  [new_action,create,edit].each { |action| action.before do object.admin_submitted = true end }

end

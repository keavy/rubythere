class Admin::EventsController < AdminAreaController
  resource_controller
  
  [create, update].each { |action| action.wants.html {redirect_to admin_events_path} }
end

class Admin::EventsController < AdminAreaController
  resource_controller
  
  [create, update].each { |action| action.wants.html {redirect_to admin_events_path} }
  
  new_action.before do
    object.admin_submitted = true
  end
  
  create.before do
    object.admin_submitted = true
  end
end

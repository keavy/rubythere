class AdminAreaController < ApplicationController
  layout 'admin'
  
  unless RAILS_ENV == 'development'
    before_filter :authenticate_for_admin
  end
end

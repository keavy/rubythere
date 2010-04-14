class AdminAreaController < ApplicationController
  layout 'admin'
  
  if RAILS_ENV == 'production'
    before_filter :authenticate_for_admin
  end
end

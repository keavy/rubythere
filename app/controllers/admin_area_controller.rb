class AdminAreaController < ApplicationController
  layout 'admin'
  
  unless Rails.env == 'development'
    before_filter :authenticate_for_admin
  end
end

class AccountsController < ApplicationController
  before_filter :authenticate
  
  def show
    @events = current_user.events
  end
end

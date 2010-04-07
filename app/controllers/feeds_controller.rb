class FeedsController < ApplicationController
  def index
    @happenings = Happening.upcoming
    
    respond_to do |format|
      format.rss { render :layout => false}
      format.xml  { render :layout => false }
    end
  end
end

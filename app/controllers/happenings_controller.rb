class HappeningsController < ApplicationController
  
  def index
    options = ['attend','speak']
    @focus  = 'attend'
    
    if params[:focus] && options.include?(params[:focus])
      @focus = params[:focus]
      @content_title = (@focus == 'speak') ? 'to speak at' : 'to attend'
    end
    
    unless fragment_exist?("happenings/#{@focus}")
      @happenings = (params[:focus] == 'speak') ? Happening.upcoming.open_for_speakers : Happening.upcoming
    end
  end
end

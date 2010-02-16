class HappeningsController < ApplicationController
  
  def index
    options = ['attend','speak']
    @focus  = 'attend'
    
    if params[:focus] && options.include?(params[:focus])
      @focus = params[:focus]
      @content_title = (@focus == 'speak') ? 'to speak at' : 'to attend'
    end
    
    @happenings = (params[:focus] == 'speak') ? Happening.upcoming.open_for_speakers : Happening.upcoming
  end
  
  def archive
    @happenings = Happening.past + Happening.unknown
  end
end

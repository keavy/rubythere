class ArchivesController < ApplicationController
  layout 'listings'
  
  def show
    @happenings = Happening.approved.past + Happening.approved.unknown unless fragment_exist?('events/archive')
  end
end

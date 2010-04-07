class ArchivesController < ApplicationController
  def show
    @happenings = Happening.approved.past + Happening.approved.unknown unless fragment_exist?('happenings/archive')
  end
end

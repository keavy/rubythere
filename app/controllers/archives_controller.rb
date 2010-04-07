class ArchivesController < ApplicationController
  def show
    @happenings = Happening.past + Happening.unknown unless fragment_exist?('happenings/archive')
  end
end

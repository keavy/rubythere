class MapsController < ApplicationController
  def show
    @locations = Happening.locations_array.to_json
  end
end
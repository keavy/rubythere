# == Schema Information
# Schema version: 20100414121512
#
# Table name: locations
#
#  id         :integer(4)      not null, primary key
#  city       :string(255)
#  state      :string(255)
#  country    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Location < ActiveRecord::Base
  has_many :happenings
  has_many :venues
  validates_presence_of :country

  default_scope :order => 'city, state, country'

  def city_state_country
    output = ""
    output += "#{city}, " unless city.blank?
    output += "#{state}" unless state.blank?
    output += ", " unless state.blank?
    output += "#{country}"
    return output
  end

  def lat_long
    geocoder = Graticule.service(:google).new APP_CONFIG[:google_map_key]
    location = geocoder.locate self.city_state_country
    lat_long = [location.latitude,location.longitude].join(",")
  rescue
    lat_long = nil
  end
end

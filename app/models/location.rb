# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  city       :string(255)
#  state      :string(255)
#  country    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lat_long   :string(255)
#

class Location < ActiveRecord::Base
  has_many :happenings
  has_many :venues
  validates_presence_of :country

  attr_accessible :city, :state, :country

  default_scope :order => 'city, state, country'

  geocoded_by :city_state_country
  after_validation :geocode

  def city_state_country
    output = ""
    output += "#{city}, " unless city.blank?
    output += "#{state}" unless state.blank?
    output += ", " unless state.blank?
    output += "#{country}"
    return output
  end

  def lat_long
    "#{latitude},#{longitude}"
  end
end

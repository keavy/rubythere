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

  before_save :set_lat_long, :on => :create

  default_scope :order => 'city, state, country'

  def city_state_country
    output = ""
    output += "#{city}, " unless city.blank?
    output += "#{state}" unless state.blank?
    output += ", " unless state.blank?
    output += "#{country}"
    return output
  end

  protected
    def geocode
      geocoder = Graticule.service(:google).new ENV['GOOGLE_MAP_KEY']
      location = geocoder.locate self.city_state_country
      [location.latitude,location.longitude].join(",")
    rescue Graticule::AddressError
      nil
    end

    def set_lat_long
      write_attribute :lat_long, self.geocode
    end
end

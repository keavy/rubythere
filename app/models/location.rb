# == Schema Information
# Schema version: 20100408082915
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
  validates_presence_of :country, :message => '^Please add a country'
  
  default_scope :order => 'city, state, country'
  
  def city_state_country
    output = ""
    output += "#{city}" unless city.blank?
    output += ", #{state}" unless state.blank?
    output += ", " unless state.blank? && city.blank?
    output += "#{country}" unless country.blank?
    return output
  end
end

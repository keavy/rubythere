# == Schema Information
# Schema version: 20100218155129
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
end

class Location < ActiveRecord::Base
  has_many :events
  validates_presence_of :city, :message => '^Please add a city'
  validates_presence_of :country, :message => '^Please add a country'
end

# == Schema Information
# Schema version: 20100218155129
#
# Table name: venues
#
#  id              :integer(4)      not null, primary key
#  name            :string(255)
#  street_address  :string(255)
#  street_address2 :string(255)
#  location_id     :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#

class Venue < ActiveRecord::Base
  belongs_to :location
  validates_presence_of :name, :message => '^Please add a name'
end

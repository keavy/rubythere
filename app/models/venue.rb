# == Schema Information
#
# Table name: venues
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  street_address  :string(255)
#  street_address2 :string(255)
#  location_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Venue < ActiveRecord::Base
  belongs_to :location
  validates_presence_of :name, :message => '^Please add a name'
end

# == Schema Information
# Schema version: 20100408082915
#
# Table name: speakers
#
#  id         :integer(4)      not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  company    :string(255)
#  twitter    :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Speaker < ActiveRecord::Base
  has_many :presentations
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
end

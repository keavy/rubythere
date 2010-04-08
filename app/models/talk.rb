# == Schema Information
# Schema version: 20100408092106
#
# Table name: talks
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Talk < ActiveRecord::Base
  has_many :presentations
  
  validates_presence_of :title
end

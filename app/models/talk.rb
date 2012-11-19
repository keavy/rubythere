# == Schema Information
#
# Table name: talks
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Talk < ActiveRecord::Base
  has_many :presentations
  
  validates_presence_of :title
  
  default_scope :order => 'title'
end

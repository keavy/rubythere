# == Schema Information
# Schema version: 20100414121512
#
# Table name: speakers
#
#  id          :integer(4)      not null, primary key
#  first_name  :string(255)
#  last_name   :string(255)
#  company     :string(255)
#  twitter     :string(255)
#  email       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  title       :string(255)
#  middle_name :string(255)
#

class Speaker < ActiveRecord::Base
  has_many :presentations
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  default_scope :order => 'first_name, last_name'
  
  def full_name
    [title, first_name, middle_name, last_name].reject(&:blank?) * ' '
  end
end

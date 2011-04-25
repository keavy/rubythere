# == Schema Information
# Schema version: 20100414121512
#
# Table name: users
#
#  id          :integer(4)      not null, primary key
#  email       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  screen_name :string(30)
#  atoken      :string(255)
#  asecret     :string(255)
#  admin       :boolean(1)
#

class User < ActiveRecord::Base
  validates_uniqueness_of :screen_name 
  attr_accessible :atoken, :asecret

  def events
    Event.find(:all).find_all {|e| e.twitter == self.screen_name}
  end
  
  def editor_for?(event)
    self.events.include?(event) || self.admin?
  end
end

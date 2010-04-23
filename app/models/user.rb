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

  def authorized?
    atoken.present? && asecret.present?
  end
  
  def oauth
    @oauth ||= Twitter::OAuth.new(APP_CONFIG['twitter_key'], APP_CONFIG['twitter_secret'])
  end
  
  delegate :request_token, :access_token, :authorize_from_request, :to => :oauth
  
  def client
    @client ||= begin
      oauth.authorize_from_access(atoken, asecret)
      Twitter::Base.new(oauth)
    end
  end
  
  def events
    Event.find(:all).find_all {|e| e.twitter == self.screen_name}
  end
  
  def editor_for?(event)
    self.events.include?(event) || self.admin?
  end
end

# == Schema Information
# Schema version: 20100414101053
#
# Table name: users
#
#  id                :integer(4)      not null, primary key
#  email             :string(255)     not null
#  crypted_password  :string(255)     not null
#  password_salt     :string(255)     not null
#  persistence_token :string(255)     not null
#  created_at        :datetime
#  updated_at        :datetime
#  screen_name       :string(30)
#  atoken            :string(255)
#  asecret           :string(255)
#

class User < ActiveRecord::Base
  acts_as_authentic
  
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
end

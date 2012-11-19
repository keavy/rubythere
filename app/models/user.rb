class User < ActiveRecord::Base

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end

  def events
    Event.find(:all).find_all {|e| e.twitter == self.screen_name}
  end

  def editor_for?(event)
    self.events.include?(event) || self.admin?
  end
end

# == Schema Information
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
#  admin       :boolean(1)      default(FALSE)
#


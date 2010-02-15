# == Schema Information
# Schema version: 20100215093935
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
#

class User < ActiveRecord::Base
  acts_as_authentic
end

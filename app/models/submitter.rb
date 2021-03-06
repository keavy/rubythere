# == Schema Information
#
# Table name: submitters
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  twitter    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Submitter < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :twitter

  has_many :events

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_length_of   :email,    :within => 3..100
  validates_format_of   :email,
                        :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                        :allow_blank => true

  def full_name
    [first_name, last_name].reject(&:blank?) * ' '
  end
end

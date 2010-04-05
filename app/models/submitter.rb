class Submitter < ActiveRecord::Base
  has_many :events
  
  validates_presence_of :first_name, :message => "^Please enter your first name"
  validates_presence_of :last_name, :message => "^Please enter your last name"
  validates_presence_of :email, :message => "^Please enter your email"
  validates_length_of   :email,    :within => 3..100
  validates_format_of   :email, 
                        :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                        :allow_blank => true
  
  def full_name
    [first_name, last_name].reject(&:blank?) * ' '
  end
end

class Submitter < ActiveRecord::Base
  has_many :events
  
  validates_presence_of :first_name, :message => "^Please enter your first name"
  validates_presence_of :last_name, :message => "^Please enter your last name"
  validates_presence_of :email, :message => "^Please enter your email"
  
  def full_name
    [first_name, last_name].reject(&:blank?) * ' '
  end
end

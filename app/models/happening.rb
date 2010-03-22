# == Schema Information
# Schema version: 20100218155129
#
# Table name: happenings
#
#  id            :integer(4)      not null, primary key
#  event_id      :integer(4)
#  url           :string(255)
#  cached_slug   :string(255)
#  description   :text
#  description_f :text
#  start_at      :datetime
#  end_at        :datetime
#  cfp_closes_at :datetime
#  cfp_open      :boolean(1)
#  open_for_reg  :boolean(1)
#  cost          :decimal(10, 2)
#  currency      :string(255)
#  sold_out      :boolean(1)
#  childcare     :boolean(1)
#  location_id   :integer(4)
#  venue_id      :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

class Happening < ActiveRecord::Base
  belongs_to :event
  belongs_to :location
  belongs_to :venue
  
  accepts_nested_attributes_for :location, :venue
  
  default_scope :order => 'start_at', :include => :location
  
  named_scope :upcoming, :conditions => "start_at > '#{Time.now.to_s(:db)}'"
  named_scope :past, :conditions => "start_at < '#{Time.now.to_s(:db)}'"
  named_scope :unknown, :conditions => {:start_at => nil}
  named_scope :open_for_speakers, :conditions => "cfp_open = 1"
  
  def status
    if sold_out
      'Sold out'
    elsif open_for_reg
      'Open for registration' unless start_at < Time.now
    else
      ''
    end
  end
end

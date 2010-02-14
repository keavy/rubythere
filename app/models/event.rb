# == Schema Information
# Schema version: 20100212211237
#
# Table name: events
#
#  id                    :integer(4)      not null, primary key
#  name                  :string(255)
#  url                   :string(255)
#  description           :text
#  description_formatted :text
#  start_date            :datetime
#  end_date              :datetime
#  cfp_date              :datetime
#  reg_date              :datetime
#  cfp_close_date        :datetime
#  cost                  :decimal(10, 2)  default(0.0)
#  currency              :string(255)
#  sold_out              :boolean(1)
#  childcare             :boolean(1)
#  created_at            :datetime
#  updated_at            :datetime
#  location_id           :integer(4)
#  venue_id              :integer(4)
#  twitter               :string(255)
#  reg_open              :boolean(1)
#

class Event < ActiveRecord::Base
  belongs_to :location
  belongs_to :venue
  
  validates_presence_of :name, :message => '^Please add a name'
  
  before_save :set_formatted_fields
  
  accepts_nested_attributes_for :location, :venue
  
  default_scope :order => 'start_date', :include => :location
  
  named_scope :upcoming, :conditions => "start_date > '#{Time.now.to_s(:db)}'"
  named_scope :past, :conditions => "start_date < '#{Time.now.to_s(:db)}'"
  named_scope :unknown, :conditions => {:start_date => nil}
  named_scope :open_for_speakers, :conditions => "proposals_open = 1 OR cfp_close_date > '#{Time.now.to_s(:db)}'"
  
  protected
  def set_formatted_fields
    if value = read_attribute(:description) then
      value = RedCloth.new(value).to_html
      write_attribute :description_formatted, value
    end
  end
end

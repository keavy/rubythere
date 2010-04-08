# == Schema Information
# Schema version: 20100408082915
#
# Table name: events
#
#  id                    :integer(4)      not null, primary key
#  name                  :string(255)
#  url                   :string(255)
#  description           :text
#  description_formatted :text
#  created_at            :datetime
#  updated_at            :datetime
#  twitter               :string(255)
#  cached_slug           :string(255)
#  approved              :boolean(1)
#  submitter_id          :integer(4)
#

class Event < ActiveRecord::Base
  has_many :happenings
  belongs_to :submitter
  
  validates_presence_of :name, :message => '^Please add a name'
 
  accepts_nested_attributes_for :happenings, :submitter
  
  before_save :set_formatted_fields
  
  default_scope :order => 'name', :include => :happenings
  named_scope :approved, :conditions => ['approved = ?', true]
  attr_accessible :name, :url, :description, :twitter, :happenings_attributes, :submitter_attributes
  attr_accessor :admin_submitted
  
  has_friendly_id :name, :use_slug => true
  
  protected
  def set_formatted_fields
    if value = read_attribute(:description) then
      value = RedCloth.new(value).to_html
      write_attribute :description_formatted, value
    end
  end
end

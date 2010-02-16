# == Schema Information
# Schema version: 20100216103653
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
#

class Event < ActiveRecord::Base
  has_many :happenings
  
  validates_presence_of :name, :message => '^Please add a name'
  
  accepts_nested_attributes_for :happenings
  
  before_save :set_formatted_fields
  
  default_scope :order => 'name'
  
  has_friendly_id :name, :use_slug => true
  
  protected
  def set_formatted_fields
    if value = read_attribute(:description) then
      value = RedCloth.new(value).to_html
      write_attribute :description_formatted, value
    end
  end
end

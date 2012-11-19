class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many :happenings
  belongs_to :submitter

  validates_presence_of :name

  accepts_nested_attributes_for :happenings, :submitter

  before_save :set_formatted_fields

  default_scope :order => 'name', :include => :happenings

  attr_accessible :name, :url, :description, :twitter, :happenings_attributes, :submitter_attributes
  attr_accessor :admin_submitted

  def self.approved
    where('approved = ?', true)
  end

  protected
  def set_formatted_fields
    if value = read_attribute(:description) then
      value = RedCloth.new(value).to_html
      write_attribute :description_formatted, value
    end
  end
end

# == Schema Information
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
#  approved              :boolean(1)      default(FALSE)
#  submitter_id          :integer(4)
#


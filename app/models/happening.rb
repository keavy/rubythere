# == Schema Information
# Schema version: 20100414121512
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
  has_many :presentations
  has_many :speakers, :through => :presentations

  validates :start_at, :presence => true
  validates :url, :presence => true
  validates_with HappeningValidator

  accepts_nested_attributes_for :location, :venue

  default_scope :order => 'start_at', :include => [:location, :event, :presentations]

  before_save :set_formatted_fields

  def self.upcoming
    where("start_at > '#{Time.now.to_s(:db)}'")
  end

  def self.approved
    where('events.approved = ?', true)
  end

  def self.unknown
    where(:start_at => nil)
  end

  def self.past
    where("start_at < '#{Time.now.to_s(:db)}'")
  end

  def self.open_for_speakers
    where("(cfp_open = 1 AND cfp_closes_at is NULL) OR (cfp_open = 1 AND cfp_closes_at > '#{Time.now.to_s(:db)}')")
  end

  def self.summaries
    select('happenings.id, happenings.event_id, happenings.start_at, events.name, events.id').order('events.name')
  end

  def status
    if sold_out
      'Sold out'
    elsif open_for_reg && start_at > Time.now
        'Open for registration'
    else
      ''
    end
  end

  def www
    url.sub(/http:\/\//, '') unless url.blank?
  end

  def past?
    return false if start_at.blank?
    if end_at
      end_at.past?
    else
      start_at.past?
    end
  end

  def summary
    event.name + ', ' + start_at.strftime("%b %Y")
  end

  def self.locations_file
    File.expand_path('../../../config/locations.yml', __FILE__)
  end

  def self.locations_array
    YAML.load_file(Happening.locations_file)
  rescue
    []
  end

  protected
  def set_formatted_fields
    if value = read_attribute(:description) then
      value = RedCloth.new(value).to_html
      write_attribute :description_f, value
    end
  end
end

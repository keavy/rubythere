# == Schema Information
#
# Table name: happenings
#
#  id            :integer          not null, primary key
#  event_id      :integer
#  url           :string(255)
#  cached_slug   :string(255)
#  description   :text
#  description_f :text
#  start_at      :datetime
#  end_at        :datetime
#  cfp_closes_at :datetime
#  cfp_open      :boolean          default(FALSE)
#  open_for_reg  :boolean          default(FALSE)
#  cost          :decimal(10, 2)
#  currency      :string(255)
#  sold_out      :boolean          default(FALSE)
#  childcare     :boolean          default(FALSE)
#  location_id   :integer
#  venue_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  cfp_url       :string(255)
#  accessible    :boolean          default(FALSE)
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

  attr_accessible :url, :description, :start_at, :end_at, :cfp_open, :cfp_url, :cfp_closes_at
  attr_accessible :sold_out, :open_for_reg, :cost, :currency, :childcare, :accessible, :location_id
  accepts_nested_attributes_for :location, :venue

  before_save :set_formatted_fields

  def self.upcoming
    where("start_at > '#{Time.now.to_s(:db)}'")
  end

  def self.approved
    includes(:event).where('events.approved = ?', true)
  end

  def self.unknown
    where(:start_at => nil)
  end

  def self.past
    where("start_at < '#{Time.now.to_s(:db)}'")
  end

  def self.open_for_speakers
    where("(cfp_open = true AND cfp_closes_at is NULL) OR (cfp_open = true AND cfp_closes_at > '#{Time.now.to_s(:db)}')")
  end

  def self.summaries
    includes(:event).select('happenings.id, happenings.event_id, happenings.start_at, events.name, events.id').order('events.name')
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

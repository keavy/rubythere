# == Schema Information
#
# Table name: presentations
#
#  id           :integer          not null, primary key
#  speaker_id   :integer
#  talk_id      :integer
#  happening_id :integer
#  keynote      :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Presentation < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :talk
  belongs_to :happening

  accepts_nested_attributes_for :speaker, :talk

  default_scope :order => 'speakers.first_name, speakers.last_name', :include => [:speaker, :talk]

  def self.keynotes
    where('keynote = ?', true)
  end

  def self.regular
    where('keynote = ?', false)
  end
end

# == Schema Information
# Schema version: 20100408092106
#
# Table name: presentations
#
#  id           :integer(4)      not null, primary key
#  speaker_id   :integer(4)
#  talk_id      :integer(4)
#  happening_id :integer(4)
#  keynote      :boolean(1)
#  created_at   :datetime
#  updated_at   :datetime
#

class Presentation < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :talk
  belongs_to :happening
  
  accepts_nested_attributes_for :speaker, :talk
  
  named_scope :keynotes, :conditions => ['keynote = ?', true]
  named_scope :regular, :conditions => ['keynote = ?', false]
end

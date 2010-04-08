class Presentation < ActiveRecord::Base
  validates_presence_of :speaker_id
  validates_presence_of :happening_id
end

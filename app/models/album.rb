class Album < ApplicationRecord
  validates :band, :name, :year, presence: true
  validates :name, uniqueness: {scope: :band_id}
  validates :year, numericality: { minimum: 1900, maximum: 2020}
 
  belongs_to :band

  after_initialize :set_defaults

  def set_defaults
    self.live ||= false
  end
end
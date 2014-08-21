class Event < ActiveRecord::Base
  validates :description, :presence => true
  validates :location, :presence => true
  validates :start, :presence => true
  validates :end, :presence => true
  # validates_datetime :start, :on_or_after => Time.now

  before_save :capitalize

  def capitalize
    self.description = self.description.capitalize
    self.location = self.location.capitalize
  end
end

class Food < ActiveRecord::Base

  # Validations
  validates :name, :calories, presence: true
  validates :name, length: {minimum: 2}
  validates :name, uniqueness: true

  # Scope methods
  scope :sort_by_cal_ASC, -> { order("calories ASC") }
  scope :sort_by_cal_DESC, -> { order("calories DESC") }

end




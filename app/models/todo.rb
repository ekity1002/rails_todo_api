class Todo < ApplicationRecord
  validates :title, presence: true
  validates :description, length: {maximum: 500}
  validate :due_date_cannot_be_in_the_past

  after_initialize :set_default_completed, if: :new_record?

  private
  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

  def set_default_completed
    self.completed = false if completed.nil?
  end
end

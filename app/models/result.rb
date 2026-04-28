class Result < ApplicationRecord
  belongs_to :campus, class_name: "Campu"

  validates :student_name, :roll_number, :academic_year, :grade, :level, :obtained_marks, :total_marks, presence: true
  validates :obtained_marks, :total_marks, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :campus, presence: true

  validate :obtained_marks_not_greater_than_total

  private

  def obtained_marks_not_greater_than_total
    if obtained_marks.present? && total_marks.present? && obtained_marks > total_marks
      errors.add(:obtained_marks, "cannot be greater than total marks")
    end
  end
end

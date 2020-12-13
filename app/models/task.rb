class Task < ApplicationRecord
  belongs_to :list
  validates :name, presence: true
  scope :incomplete_first, -> { order(completed_at: :desc) }

  def complete?
    completed_at.present?
  end
end

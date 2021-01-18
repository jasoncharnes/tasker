class Task < ApplicationRecord
  acts_as_list scope: [:list_id, completed_at: nil], top_of_list: 0
  belongs_to :assignee, class_name: "User", optional: true
  belongs_to :completer, class_name: "User", optional: true
  belongs_to :creator, class_name: "User"
  belongs_to :list
  has_many :comments, as: :commentable
  validates :name, presence: true
  scope :incomplete_first, -> { order(completed_at: :desc) }
  delegate :name, to: :assignee, prefix: true, allow_nil: true
  delegate :name, to: :completer, prefix: true, allow_nil: true

  def complete?
    completed_at.present?
  end
end

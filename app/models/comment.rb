class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  delegate :name, to: :user, prefix: true
  validates :body, presence: true
end

class List < ApplicationRecord
  has_many :tasks, -> { incomplete_first.order(position: :asc) }, dependent: :destroy
end

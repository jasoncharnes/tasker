class List < ApplicationRecord
  has_many :tasks, dependent: :destroy
end

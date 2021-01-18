class List < ApplicationRecord
  has_many :tasks, -> { incomplete_first.order(position: :asc) }, dependent: :destroy
  validates :name, presence: true

  def client_id
    @client_id ||= SecureRandom.uuid
  end
end

class Category < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  scope :active, lambda {
    where(active: true)
  }

  scope :ordered, lambda {
    order(:name)
  }
end

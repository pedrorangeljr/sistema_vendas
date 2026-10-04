class Category < ApplicationRecord
  # uma categoria pode possuir varios produtos
  has_many :products, dependent: :restrict_with_error

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :active, lambda {
    where(active: true)
  }

  scope :ordered, lambda {
    order(:name)
  }
end

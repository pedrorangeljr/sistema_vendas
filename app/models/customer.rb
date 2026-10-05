class Customer < ApplicationRecord
  has_many :sales, dependent: :restrict_with_error

  before_validation :normalize_data

  validates :name, presence: true

  validates :cpf,
            presence: true,
            uniqueness: true

  validates :cpf,
            presence: true,
            uniqueness: true

  validates :email,
            presence: true,
            allow_blank: true

  validates :state,
            length: { is: 2 },
            allow_blank: true

  scope :active, lambda  {
    where(active: true)
  }

  scope :inactive, lambda {
    where(active: false)
  }

  scope :ordered, lambda {
    order(:name)
  }

  private

  def normalize_data
    self.cpf = cpf.to_s.gsub(/\D/, '')

    self.email = email.to_s.strip.downcase.presence

    self.state = state.to_s.strip.upcase.presence
  end
end

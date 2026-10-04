class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :sku, presence: true, uniqueness: true

  validates :cost_price,
            numericality: { greater_than_or_equal_to: 0 }

  validates :price,
            numericality: { greater_than_or_equal_to: 0 }

  validates :stock_quantity,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  validates :minimum_stock,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  validate :price_must_be_greater_than_or_equal_to_cost

  scope :active, lambda {
    where(active: true)
  }

  scope :ordered, lambda {
    order(:name)
  }

  scope :low_stock, lambda {
    where('stock_quantity <= minimum_stock')
  }

  private

  # metodo não deixa o preço de venda ser menor que o preço de custo
  def price_must_be_greater_than_or_equal_to_cost
    return if cost_price.blank? || price.blank?

    return unless price < cost_price

    errors.add(
      :price,
      'deve ser maior ou igual ao preço de custo'
    )
  end
end

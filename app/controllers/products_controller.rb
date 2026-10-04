class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).ordered

    if params[:search].present?
      search = "%#{params[:search]}%"

      @products = @products.where(
        'products.name ILIKE :search OR products.sku ILIKE :search',
        search: search
      )
    end

    if params[:category_id].present?
      @products = @products.where(
        category_id: params[:category_id]
      )
    end

    @categories = Category.ordered
  end

  def show
    @product = Product.includes(:category).find(params[:id])
  end

  def new
    @product = Product.new
    @categories = Category.active.ordered
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path,
                  notice: 'Produto criado com sucesso.'
    else
      @categories = Category.active.ordered

      render :new,
             status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.active.ordered
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path,
                  notice: 'Produto atualizado com sucesso.'
    else
      @categories = Category.active.ordered

      render :edit,
             status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path,
                notice: 'Produto excluído com sucesso.'
  end

  private

  def product_params
    params.require(:product).permit(
      :category_id,
      :name,
      :sku,
      :description,
      :cost_price,
      :price,
      :stock_quantity,
      :minimum_stock,
      :active
    )
  end
end

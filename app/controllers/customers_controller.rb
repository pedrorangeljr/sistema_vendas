class CustomersController < ApplicationController
  def index
    @customers = Customer.ordered

    if params[:search].present?
      search = "%#{params[:search]}%"

      @customers = @customers.where(
        "name ILIKE :search
         OR cpf ILIKE :search
         OR email ILIKE :search",
        search: search
      )
    end

    if params[:status] == 'active'
      @customers = @customers.active
    elsif params[:status] == 'inactive'
      @customers = @customers.inactive
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to customers_path,
                  notice: 'Cliente criado com sucesso.'
    else
      render :new,
             status: :unprocessable_entity
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])

    if @customer.update(customer_params)
      redirect_to customers_path,
                  notice: 'Cliente atualizado com sucesso.'
    else
      render :edit,
             status: :unprocessable_entity
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    redirect_to customers_path,
                notice: 'Cliente excluído com sucesso.'
  end

  private

  def customer_params
    params.require(:customer).permit(
      :name,
      :cpf,
      :email,
      :phone,
      :zip_code,
      :street,
      :number,
      :complement,
      :neighborhood,
      :city,
      :state,
      :active
    )
  end
end

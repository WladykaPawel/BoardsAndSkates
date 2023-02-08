class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
    @borrowed = ItemsBorrowed.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def decrement_and_show_message
    @product = Product.find(params[:id])
    if @product.quantity > 0
      @product.update(quantity: @product.quantity - 1)
      @product.update(borrowed: @product.borrowed + 1)

      old_number=Number.find_by(id:1).numer
      Number.find_by(id:1).update(numer:old_number + 1 )

      number=Number.find_by(id:1).numer
      name=@product.title
      data=@product.updated_at
      given=false
      @borrowed = ItemsBorrowed.new(numer: number, title: name, date: data, given: given)

      respond_to do |format|
        format.json { render json: { message: "Successful rental", quantity: @product.quantity } }
        format.html { redirect_to rental_successful_path }
        @borrowed.save
      end
    else
      respond_to do |format|
        format.json { render json: { message: "Out of stock. Cannot rent." } }
      end
    end
  end

  def decrement_as_admin
    @product = Product.find(params[:id])
    @product.update(quantity: @product.quantity - 1)
    @product.update(borrowed: @product.borrowed + 1)
    respond_to do |format|
      format.json { render json: { message: "Successful", quantity: @product.quantity } }
      format.json { render json: { message: "Successful", borrowed: @product.borrowed } }
    end
  end

  def add_quantity
    @product = Product.find(params[:id])
    @product.update(quantity: @product.quantity + 1)
    @product.update(borrowed: @product.borrowed - 1)
    respond_to do |format|
      format.json { render json: { message: "Successful", quantity: @product.quantity } }
      format.json { render json: { message: "Successful", borrowed: @product.borrowed } }
    end
  end


  def check_password
    if params[:password] == 'haslo'
      redirect_to products_path, alert: "Hasło poprawne"
    else
    end
  end

  def give
    @borrowed = ItemsBorrowed.find(params[:id])
    @borrowed.update(given: true )
    respond_to do |format|
      format.json { render json: { message: "Successful", given: @borrowed.given } }
    end
  end

  def destroy_borrowed
    @borrowed = ItemsBorrowed.find(params[:id])
    @product = Product.find_by(title: @borrowed.title)
    @product.update(quantity: @product.quantity + 1)
    @product.update(borrowed: @product.borrowed - 1)
    @borrowed.destroy

    respond_to do |format|
      format.json { render json: { message: "Successful"} }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :price, :quantity, :borrowed)
    end


end

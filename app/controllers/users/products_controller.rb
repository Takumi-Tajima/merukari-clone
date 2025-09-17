class Users::ProductsController < Users::ApplicationController
  before_action :set_product, only: %i[edit update destroy]

  def new
    @product = current_user.products.build
  end

  def edit
  end

  def create
    @product = current_user.products.build
    if @product.save
      redirect_to product_path(@product), notice: '商品を登録しました。'
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product), notice: '商品を更新しました。'
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @product.destroy!
    redirect_to products_path, notice: '商品を削除しました。'
  end

  private

  def set_product
    @product = current_user.products.find(params.expect(:id))
  end

  def product_params
    params.expect(product: %i[category_id name description price])
  end
end

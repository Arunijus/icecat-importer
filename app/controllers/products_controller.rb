class ProductsController < ApplicationController
  def index
    @products = Product.all.includes(
        :assortment,
        :product_attribute_values,
        variations: [:variation_gtins, :variation_photos]
    )
    @shops = Shop.all
  end

  def edit
    @product = Product.find(params[:id])
    @families = ProductFamily.all
  end

  def update
    @family = ProductFamily.find(params[:family_id])
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to(:action => 'index')
    else
      render 'edit'
    end
  end

  private

  def product_params
    params.require(:supplier).permit(:name, :address)
  end
end

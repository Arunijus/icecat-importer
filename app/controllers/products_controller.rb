class ProductsController < ApplicationController
  def index
    @products = Product.all.includes(
        :assortment,
        :product_attribute_values,
        variations: [:variation_gtins, :variation_photos]
    ).page params[:page]
    @shops = Shop.all
  end

  def edit
    @product = Product.find(params[:id])
    @families = ProductFamily.all
  end

  def update
    @family = ProductFamily.find(product_params[:family_id])
    @product = Product.includes(
        :assortment,
        :product_attribute_values,
        variations: [:variation_photos]
    ).find(params[:id])

    if @product.update(product_params)
      redirect_to(:action => 'index')
    else
      render 'edit'
    end
  end

  private

  def product_params
    params.require(:product).permit(:family_id)
  end
end

class ProductsController < ApplicationController
  def index
    @products = Search.filter_products(params)
    @categories = Category.all
  end

  def show
    session[:return_to] = request.fullpath
    @product = Product.find(params[:id])
    @ratings = RatingsRepository.ratings_for(params[:id])
  end
end

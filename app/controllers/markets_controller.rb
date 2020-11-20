class MarketsController < ApplicationController
  def index
    @products = Product.all
    @category = Category.all
    if params[:word]
      @products = Product.where('name like ?', "%#{params[:word]}%")
    end
    
    if params[:keyword]
      @products = @products.where('name like ?', "%#{params[:keyword]}%")
    end
    
    if params[:search].present? && params[:search][:category_id].present?
      @products = @products.where(:category_id =>params[:search][:category_id])
    end
    if params[:min_price].present?
      @products = @products.where('price >= ?',params[:min_price])
    end
    if params[:max_price].present?
      @products = @products.where('price <= ?',params[:max_price])
    end
    
    if params[:line].present?
      @products = @products.order(params[:line])
    else
      @products = @products.order('id desc')
    end
  
    
  end
  
  def show
    @product = Product.find(params[:id])
    @category = Category.all
  end
  
  def payment
    @product = Product.find(params[:id])
    @category = Category.all
  end
  
  def payment_process
    product=Product.find(params[:id])
    product.update(:status=>0)
    redirect_to top_path
  end
  
end

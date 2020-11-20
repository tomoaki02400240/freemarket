class Users::ProductsController < ApplicationController
  before_action :authorize
  # def item_list
   # @products = Product.all
    # if params[:keyword]
      # @products = @products.where('name like ?',"%#{params[:keyword]}%")
    #3end
    # if params[:min_price]
      #@products=@products.where(:price>=params[:min_price])
    #end
    
    #Product.all.where('name like ?',"%#{params[:keyword]}%").where(:price>=params[:min_price]).where(:price<=params[:max_price]).where(:category_id=>params[:category_id]).order('id','desc')
    
    
  #end
  def index
    @products = Product.where(user_id: current_user.id).order("id desc")
  end
  
  def new
    @product = Product.new
    @categories = Category.all
  end
  
  
  def create
    
    upload_file1 = params[:product][:image1]
    upload_file2 = params[:product][:image2]
    upload_file3 = params[:product][:image3]
    output_dir = Rails.root.join('public', 'images')
     
    if upload_file1.present?
      upload_file_name1 = upload_file1.original_filename
      output_path = output_dir + upload_file_name1
      File.open(output_path, 'w+b') do |f|
        f.write(upload_file1.read)
      end
    end
    
    if upload_file2.present?
      upload_file_name2 = upload_file2.original_filename
      output_path = output_dir + upload_file_name2
      File.open(output_path, 'w+b') do |f|
        f.write(upload_file2.read)
      end
    end 
    
    if upload_file3.present?
      upload_file_name3 = upload_file3.original_filename
      output_path = output_dir + upload_file_name3
      File.open(output_path, 'w+b') do |f|
        f.write(upload_file3.read)
      end
    end
    @product = Product.new(product_params.merge({image1: upload_file_name1, image2: upload_file_name2, image3: upload_file_name3}))
    
    
    if @product.save
      flash[:success] = "投稿しました"
      redirect_to users_product_path(@product)
    else
      flash[:danger] = "投稿に失敗しました"
      redirect_to users_new_products_path
    end
    
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def edit
    @product = Product.find(params[:id])
    
  end
  
  def update
    @product = Product.find(params[:id])
    upload_file1 = params[:product][:image1]
    upload_file2 = params[:product][:image2]
    upload_file3 = params[:product][:image3]
    if upload_file1.present?
      upload_file_name1 = upload_file1.original_filename
      output_dir = Rails.root.join('public', 'images')
      output_path = output_dir + upload_file_name1
      File.open(output_path, 'w+b') do |f|
        f.write(upload_file1.read)
      end
    end
    
    if upload_file2.present?
      upload_file_name2 = upload_file2.original_filename
      output_dir = Rails.root.join('public', 'images')
      output_path = output_dir + upload_file_name2
      File.open(output_path, 'w+b') do |f|
        f.write(upload_file2.read)
      end
    end
    
    if upload_file3.present?
      upload_file_name3 = upload_file3.original_filename
      output_dir = Rails.root.join('public', 'images')
      output_path = output_dir + upload_file_name3
      File.open(output_path, 'w+b') do |f|
        f.write(upload_file3.read)
      end
    end
    
    if @product.update(product_params.merge({image1: upload_file_name1, image2: upload_file_name2, image3: upload_file_name3}))
      flash[:success] = '更新しました'
      redirect_to users_product_path(@product)
    else
      flash[:danger] = '更新できませんでした'
      redirect_to users_edit_products_path(@product)
    end
  end
  
  
  def destroy
    product = Product.find(params[:id])
    product.destroy
    flash[:success] = "削除しました"
    redirect_to users_products_path
  end
  private
  def product_params
    params.require(:product).permit(:name, :description, :category_id, :price, :image1, :image2, :image3).merge({user_id: current_user.id})
  end
end

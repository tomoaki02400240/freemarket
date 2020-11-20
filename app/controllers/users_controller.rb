class UsersController < ApplicationController
  before_action :authorize, except: [:sign_up, :sign_in, :sign_up_process, :sign_in_process]
  def profiles
    
  end
  
  def like
    @product = Product.find(params[:id])
    if UserLike.exists?(product_id: @product.id, user_id: current_user.id)
      UserLike.find_by(product_id: @product.id, user_id: current_user.id).destroy
    else
      UserLike.create(product_id: @product.id, user_id: current_user.id)
    end
    @userlikes = UserLike.where(user_id: current_user.id)
    redirect_to top_path
  end
  
  def moment
    @userlikes = UserLike.where(user_id: current_user.id)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    upload_file = params[:user][:image]
    
    if upload_file.present?
      upload_file_name = upload_file.original_filename
      output_dir = Rails.root.join('public', 'users')
      output_path = output_dir + upload_file_name
      File.open(output_path, 'w+b') do |f|
        f.write(upload_file.read)
      end
      if @user.update(edit_password_params.merge({image: upload_file.original_filename}))
        flash[:success] = "編集しました"
        redirect_to profiles_path
      else
        flash[:danger] = "編集できませんでした"
        redirect_to profiles_edit_path(@user)
      end
      
      if params[:user][:password].blank?
        @user.update(edit_params.merge({image: upload_file.original_filename}))
        flash[:success] = "編集しました（パスワード以外）"
        profiles_path
      end

    else
      #@user.errors.full_messages.each do |m|
      #  flash[:danger] = m
      #end
      #flash[:danger]='aaaaa'
      
      if  @user.update(edit_password_params)
        flash[:success]='変更しました'
        redirect_to profiles_path
      else
        flash[:danger] = "変更できませんでした"
        redirect_to profiles_edit_path(@user) and return
      end
      
      if params[:user][:password].blank?
        @user.update(edit_params)
        flash[:success]= "変更しました（パスワード以外）"
        profiles_path 
      end
      #flash[:danger] = "画像を投稿してください"
     
      
    end
  end
  
  def sign_up
    @user = User.new
    @category = Category.all
  
  end
  
  def sign_up_process
    @user = User.new(user_params)
    @category = Category.all
      if @user.save
        user_sign_in(@user)
        flash[:success] = "新規登録しました"
        redirect_to profiles_path
      else
        flash[:danger] = "新規登録できませんでした"
        render 'sign_up'
      end
    
  end
  
  def sign_in
    
  end
  
  def sign_in_process
    user = User.find_by(email: params[:session][:email])
    
    if user && user.authenticate(params[:session][:password])
      user_sign_in(user)
      flash[:success] = 'ログインしました'
      redirect_to profiles_path
    else
      flash[:danger] = "ログインできませんでした"
      render 'sign_in'
    end
    
  end
  
  def sign_out
    session.delete(:user_id)
    @current_user = nil
    flash[:success] = "ログアウトしました"
    redirect_to sign_in_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,   :password_confirmation)
  end
  
  def edit_password_params
    params.require(:user).permit(:name, :profile, :password, :password_confirmation)
  end
  
  def edit_params
    params.require(:user).permit(:name, :profile)
  end
end

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order(created_at: "DESC")
  end

  def new
    @user = User.new
    if logged_in?
      redirect_to posts_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: 'User was successfully created'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), success: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def favourite
    @user = User.find(params[:id])
    @favorites = current_user.favorite_posts.all
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to new_user_path, notice: 'User was successfully destroyed.'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation )
  end
end

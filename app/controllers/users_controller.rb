class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def new
    @user = User.new
  end

  def confirm
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    unless logged_in?
      authenticate_user
    end
    @posts = Post.where(user_id:@user.id).order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "User was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to new_user_path, notice: "User was successfully destroyed"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:profile_image,:profile_image_cache, :name, :email, :password, :password_confirmation, :profile_content)
  end

end

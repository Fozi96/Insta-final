class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :need_login, only: [:index, :new, :edit, :show, :destroy]

  def index
    @posts = post.all.order(created_at: :desc)
    # @user = User.find(current_user.id)
    # @favorites = current_user.favorites
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
    @user = User.find(@post.user.id)
  end

  def new
    if params[:back]
      @post = post.new(post_params)
      @user = User.find(current_user.id)
    else
      @post = post.new
      @user = User.find(current_user.id)
    end
  end

  def confirm
    @post = current_user.posts.build(post_params)
    @user = User.find(current_user.id)
    render :new if @post.invalid?
  end

  def edit
    @user = User.find(current_user.id)
  end

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        ConfirmMailer.confirm_mail(@post).deliver
        format.html { redirect_to @post, notice: '投稿されました' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if current_user == @post.user
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: '更新されました' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if current_user == @post.user
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: '投稿を削除しました' }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_post
    @post = post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :content, :image_cache)
  end

  def need_login
    unless logged_in?
      authenticate_user
    end
  end

end

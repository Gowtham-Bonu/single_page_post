class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.where(user_id: current_user.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Post was successfully created." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: " Post was successfully destroyed." }
      format.turbo_stream
    end
  end

  def explore
    @posts = Post.all
  end

  

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :user_id, :description)
  end
end

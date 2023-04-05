class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post, only: [:edit, :update, :destroy, :comment, :like]

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
  end

  def update
    if @post.update(post_params)
      redirect_to root_path, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: " Post was successfully destroyed." }
      format.turbo_stream
    end
  end

  def explore
    @posts = Post.all
  end

  def comment
    comment = @post.comments.create(description: params[:description])
    @comments = @post.comments
  end

  def like
    if @post.liked?
      @post.update(like: 1)
    else
      @post.update(like: 0)
    end
  end

  private

  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :user_id, :description)
  end
end

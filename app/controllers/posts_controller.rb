class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post, except: [:index, :new, :create, :explore]

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
      flash.now[:alert] = "post isn't created! try again . . ."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to root_path, notice: "Post was successfully updated."
    else
      flash.now[:alert] = "post isn't created! try again . . ."
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
    @post.comments.create(description: params[:description])
    @comments = @post.comments
  end

  def like
    @like =  Like.find_or_create_by(user_id: current_user.id, post_id: @post.id)
    @like.liked? ? @like.update(status: 1) : @like.update(status: 0)
  end

  private

  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :user_id, :description)
  end
end

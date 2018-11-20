class PostsController < ApplicationController
  before_action :signed_in_leader_or_admin
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params.merge({
      user: current_user,
      club: current_user.first_club
    }))

    if @post.save
      flash[:success] = 'Posted!'
      redirect_to @post
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      flash[:success] = 'Saved!'
      redirect_to @post
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    flash[:success] = 'Post deleted.'
    redirect_to posts_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:name, :url, :file)
  end
end

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(Uploader.upload(post_params))
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  def upvote
    @post = Post.find(params[:id])

    if @post.upvote_by current_user
      render json: @post
    elsif
      render json: 'Upvote Failed'
    end
    # redirect_to :back

  end

  def downvote
    @post = Post.find(params[:id])

    if @post.downvote_by current_user
      render json: @post
    elsif
      render json: 'Downvote Failed'
    end
    # redirect_to :back

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :body, :stop_id, :user_id)
    end
end

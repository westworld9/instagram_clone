class PostsController < ApplicationController 
  before_action :set_post, only:[:show, :edit, :update, :destroy]
  before_action :login_user, only:[:index, :new, :show, :edit,:destroy]
  def index
    @posts=Post.all.includes(:user).order(created_at: :desc)
  end

  def new
    @post=Post.new
  end
  def create 
    @post=current_user.posts.build(post_params)
    
    if @post.save 
      PostMailer.post_mailer(@post).deliver
      redirect_to posts_path 
    else 
      render 'new'
    end
  end

  def show
  end

  def edit
  end 
  def update 
    if @post.update(post_params)
      redirect_to posts_path 
    else 
      render "edit" 
    end
  end 
  def destroy 
    @post.destroy 
    redirect_to posts_path
  end
  def post_params 
    params.require(:post).permit(:content, :image)
  end
  def set_post 
    @post=Post.find(params[:id])
  end
  def login_user
    if current_user.nil? 
      flash[:notice]="ログインしてください"
      redirect_to new_session_path
    end
  end
end

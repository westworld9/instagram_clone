class PostsController < ApplicationController 
  before_action :set_post, only:[:show, :edit, :update, :destroy]
  before_action :login_user, only:[:new, :show, :edit,:destroy]
  before_action :edit_userpost, only:[:edit, :destroy]
  def index
    @posts=Post.all.includes(:user).order(created_at: :desc)
  end

  def new
    @post=if params[:back]
            Post.new(post_params)
          else
            Post.new
          end
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
  def confirm
    @post=Post.new(post_params)
    @post.user_id = current_user.id 
    render :new if @post.invalid?
  end
  
  private
  
  def post_params 
    params.require(:post).permit(:content, :image,:image_cache )
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
  def edit_userpost
    if @post.user_id != current_user.id 
      flash[:notice]="権限がありません"
      redirect_to posts_path 
    end
  end
end

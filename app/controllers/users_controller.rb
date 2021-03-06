class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update]
  before_action :edit_userpost, only:[:edit]
  def new
    @user=User.new
  end
 
  def create 
    @user=User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  def show 
  end

  def edit
    
  end 
  def update 
    if @user.update(user_params)
      redirect_to user_path(@user) 
    else 
      render "edit" 
    end
  end
  private 
  def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :icon_cache, :bio)
  end
  def set_user 
    @user=User.find(params[:id])
  end
 
  def edit_userpost
    if @user.id != current_user.id 
      flash[:notice]="権限がありません"
      redirect_to posts_path 
    end
  end
end

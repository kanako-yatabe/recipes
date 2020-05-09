class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :authenticate_user, only: [:update, :edit, :destroy]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order(id: :desc).page(params[:page])
    @followings = @user.followings.page(params[:page])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザー登録が完了しました！'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
     redirect_to @user
   else
    render :edit
   end
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.fav_recipes.page(params[:page])
    counts(@user)
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation)
  end
  
  def authenticate_user
    if @current_user == nil
      redirect_to root_url
    end
  end

end

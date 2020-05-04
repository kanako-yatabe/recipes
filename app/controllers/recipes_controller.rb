class RecipesController < ApplicationController
  before_action :require_user_logged_in, only: [:create, :edit, :destroy]
  before_action :correct_user, only: [:edit, :destroy]
  def index
    if logged_in?
      @recipes_all = Recipe.all
      @recipes = @recipes_all.where(user_id: @follow_users).order(id: :desc).page(params[:page])
    end  
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:success] = 'レシピを投稿しました！'
      redirect_to root_url
    else
      @recipes = current_user.recipes.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'recipes/index'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      flash[:success] = 'レシピを更新しました'
      redirect_to @message
    else
      flash.now[:danger] = 'レシピの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:success] = 'レシピを削除しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:title, :material, :image, :cooking_time, :process, :comment)
  end
  
  def correct_user
    @recipe = current_user.recipes.find_by(id: params[:id])
    unless @recipe
      redirect_to root_url
    end
  end
end

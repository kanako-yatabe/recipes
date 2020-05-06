class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    recipe = Recipe.find(params[:recipe_id])
    current_user.favorite(recipe)
    flash[:success] = 'レシピを「お気に入り」に保存しました！'
    redirect_to recipe_path(recipe) 
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    current_user.unfavorite(recipe)
    flash[:success] = 'レシピを「お気に入り」から削除しました'
    redirect_to recipe_path(recipe) 
  end
end

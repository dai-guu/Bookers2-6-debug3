class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    book = Book.find(params[:book_id])
  	favorite = current_user.favorites.new(book_id: book.id)
  	favorite.save
  	
  	#@favorite_count = Favorite.where(book_id: params[:book_id]).count
  	#redirect_back fallback_location: root_path
  	redirect_to request.referer
  end


  def destroy
    book = Book.find(params[:book_id])
  	favorite = current_user.favorites.find_by(book_id: book.id)
  	favorite.destroy
  	#@favorite_count = Favorite.where(book_id: params[:book_id]).count
  	#redirect_back fallback_location: root_path
  	redirect_to request.referer
  end
end

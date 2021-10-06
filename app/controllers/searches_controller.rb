class SearchesController < ApplicationController

  def search
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:word], params[:search])  
    else
      @books = Book.looks(params[:word], params[:search])
    end
  end
end





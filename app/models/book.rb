class Book < ApplicationRecord


    belongs_to :user #Userモデルと1：N

    has_many :favorites, dependent: :destroy
    has_many :book_comments, dependent: :destroy

     def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
     end



     def self.looks(word, search)   #(search, word)にしない controllerと順番合わせる
         @book = Book.all
       if search == "perfect_match"

         @book = Book.where("title LIKE?","#{word}")      
       elsif search == "forward_match"
         @book = Book.where("title LIKE?","#{word}%")       
       elsif search == "backward_match"
         @book = Book.where("title LIKE?","%#{word}")
       elsif search == "partial_match"
         @book = Book.where("title LIKE?","%#{word}%")
       else
         @book        #rb:16で定義してるから=Book.allはいらない
       end
    end





    validates :title, presence: true
    validates :body, presence: true,
              length: { maximum: 200 }



end



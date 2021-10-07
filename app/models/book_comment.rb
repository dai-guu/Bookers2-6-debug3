class BookComment < ApplicationRecord

 belongs_to :user
  belongs_to :book
  
  #バリデーション
  validates :content, presence: true


end

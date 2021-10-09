class BookComment < ApplicationRecord

 belongs_to :user
  belongs_to :book

  #バリデーション
  validates :comment, presence: true


end

class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :book_id, scope: :user_id     #validates_uniqueness_of :book_id →いいね♡の重複防止
                                                        # scope: :user_id  →それぞれのuserがいいね♡１個ずつ付けれる。
end                                                       #逆にいいね１個だけ（♡1）にしたい場合は外す

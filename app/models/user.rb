class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  #フォロー・フォロワー機能
  # ====================自分がフォローしているユーザーとの関連 ===================================

   has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy


   has_many :followers, through: :reverse_of_relationships, source: :follower


   # ====================自分がフォローされるユーザーとの関連 ===================================

   has_many :relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy


   has_many :followings, through: :relationships, source: :followed


  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
   #def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザーの中から、引数に渡されたユーザー(自分)がいるかどうかを調べる



  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる
  validates :name, uniqueness: true
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 }


end
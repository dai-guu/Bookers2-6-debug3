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
  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
   has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

    # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「followings」と定義
   has_many :followers, through: :reverse_of_relationships, source: :follower


   # ====================自分がフォローされるユーザーとの関連 ===================================
    #フォローされる側のUserから見て、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローされる側)
   has_many :relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy

    # 中間テーブルを介して「following」モデルのUser(フォローする側)を集めることを「followers」と定義
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
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    #passive_relationships.find_by(following_id: user.id).present?
   #end


  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる
  validates :name, uniqueness: true
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 }


end
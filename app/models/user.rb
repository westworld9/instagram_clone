class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 30}
    validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: true
    before_validation { email.downcase! }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    mount_uploader :icon, IconUploader
    has_many :posts
    has_many :favorites, dependent: :destroy
    has_many :favorite_posts, through: :favorites, source: :post
    has_many :active_relationships, class_name: "Relationship",foreign_key: :following_id
    has_many :followings, through: :active_relationships, source: :follower 
    has_many :passive_relationships, class_name: "Relationship",foreign_key: :follower_id
    has_many :followers, through: :passive_relationships, source: :following
    
    def followed_by?(user)
      passive_relationships.find_by(following_id: user.id).present? 
    end
end

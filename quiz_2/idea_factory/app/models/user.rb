class User < ApplicationRecord
    has_secure_password
    validates(:email, presence: true, uniqueness: true)
    has_many :ideas, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_many :likes, dependent: :destroy
    has_many :liked_ideas, through: :likes, source: :idea
end

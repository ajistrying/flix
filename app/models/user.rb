class User < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  has_secure_password

  validates :name, presence: true

  validates :username, 
    presence: true,
    format: { with: /\A[A-Z0-9]+\z/i }, 
    uniqueness: {case_sensitive: false}

  #Validate that email is unique within database, regardless of case
  validates :email, 
    format: { with: /\S+@\S+/ }, 
    uniqueness: {case_sensitive: false}

  validates :password, length: { minimum: 10, allow_blank:true}

end

class User < ActiveRecord::Base
	validates :email, uniqueness: true,format: {with: /[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+/, message: "Email can only have lowercase or uppercase letters, numbers, underscores, dashes, or periods."}
	validates :email, :password, presence:true
	validates :username, uniqueness: true
	validates :password, length: {minimum: 6}, confirmation: true
	validates :password_confirmation, presence: true

	has_secure_password validations: false
	
	has_many :questions
	has_many :answers
end
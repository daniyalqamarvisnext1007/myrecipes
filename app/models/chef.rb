class Chef < ApplicationRecord
	before_save { self.email = email.downcase}
	validates :chefname, presence: true, length: { maximum: 30 }
	VALID_EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
	validates :email, presence: true, length: { maximum: 255 },
				format: { with: VALID_EMAIL_REGEX},
				uniqueness: { case_sensitive: false}


	has_many :recipes
	has_secure_password
	validates :password, presence: true, length: {minimum: 5}, allow_nil: true

	default_scope -> { order(updated_at: :desc)}

end 
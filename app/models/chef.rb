class Chef < ApplicationRecord
	before_save { self.email = email.downcase}
	validates :chefname, presence: true, length: { maximum: 30 }
	VALID_EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
	validates :email, presence: true, length: { maximum: 255 },
				format: { with: VALID_EMAIL_REGEX},
				uniqueness: { case_sensitive: false}
end 
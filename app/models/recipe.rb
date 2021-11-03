class Recipe < ApplicationRecord
	validates :name, presence: true
	validates :email, presence: true, length: { minimum: 5, maximum: 500}
end
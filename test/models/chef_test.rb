require 'test_helper'

class ChefTest < ActiveSupport::TestCase


	def setup
		@chef = Chef.new(chefname: "Daniyal", email: "daniyal@visnext.com",
			password: "password123", password_confirmation: "password123")
	end

	test "should be valid" do
		assert @chef.valid?
	end

	test "name should be present" do
		@chef.chefname = " "
		assert_not @chef.valid?
	end

	test "name should be less than 30" do
		@chef.chefname = "d" * 31
		assert_not @chef.valid?
	end


	test "email should be present" do
		@chef.email = " "
		assert_not @chef.valid?
	end

	test "email should be not too long" do
		@chef.email = " d " * 245 + "@example.com"
		assert_not @chef.valid?
	end

	test "email should accept correct format" do
		valid_emails = %w[user@example.com daniyalqamar@gmail.com]
		valid_emails.each do |valids|
			@chef.email = valids
			assert @chef.valid?, "#{valids.inspect} should be valid"
		end 
	end

	test "email should reject invalid addresses" do
		valid_emails = %w[user@example daniyalqamar@gmail,com]
		valid_emails.each do |invalids|
			@chef.email = invalids
			assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
		end 
	end

	test "email should be unique" do
		duplicate_chef = @chef.dup
		duplicate_chef.email = @chef.email.upcase
		@chef.save 
		assert_not duplicate_chef.valid?
	end

	test "email should be lower case before hitting database" do
		mixed_email = "DanIYal@gmail.com"
		@chef.email = mixed_email
		@chef.save
		assert_equal mixed_email.downcase, @chef.reload.email
	end

	test "password should be present" do
		@chef.password = @chef.password_confirmation = " "
		assert_not @chef.valid?
	end


	test "associated recipes should be destroyed" do
		@chef.save
		@chef.recipes.create!(name: "testing destroyed", description: "testing destroy function")
		assert_difference 'Recipe.count', -1 do
			@chef.destroy
		end
	end

end
require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

def setup
	@recipe = Recipe.new(name: "Butter Chicken", email: "Take some chicken and butter")
end


test "recipe should be valid" do
	assert @recipe.valid?
end

test "name should be present" do
	@recipe.name = " "
	assert_not @recipe.valid?
end

test "description should be present" do
	@recipe.email = " "
	assert_not @recipe.valid?
end

test "description shouldn't be less than 5" do
	@recipe.email = "d" * 3
	assert_not @recipe.valid?
end

test "description shouldn't be more than 500" do
	@recipe.email = "d" * 501
	assert_not @recipe.valid?
end

end
require "test_helper"

class RecipesTest < ActionDispatch::IntegrationTest


  def setup

    @chef = Chef.create!(chefname: "daniyal", email: "dnaiyal@gmail.com")
    @recipe = Recipe.create(name: "vegetable saute", email: "asdfsdf asfdjkjre lkljwqw ", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "chikcen sature", email: "greate dish")
    @recipe2.save   
  end


  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end


  test "should get list of recipes" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
  end

end

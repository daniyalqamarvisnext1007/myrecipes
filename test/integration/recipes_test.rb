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
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end


  # test "should get recipes show" do

  #   get recipes_path(@recipe)
  #   assert_template 'recipes/show'
  #   assert_match @recipe.name, response.body
  #   assert_match @recipe.email, response.body
  #   assert_match @chef.chefname, response.body

  # end


  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "chicken saute"
    email_of_recipe = "add chicken, add veggies etc."
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: { name: name_of_recipe, email: email_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match email_of_recipe, response.body
 
  end


  test "reject invalid recipe submission" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { name: " ", email: " " }}
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'

  end

end

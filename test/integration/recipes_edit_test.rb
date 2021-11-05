require "test_helper"

class RecipesEditTest < ActionDispatch::IntegrationTest

    def setup

    @chef = Chef.create!(chefname: "daniyal", email: "dnaiyal@gmail.com")
    @recipe = Recipe.create(name: "vegetable saute", email: "daniyalqamar@visnext.com ", chef: @chef)

    end


    test "reject invalid recipe update" do
      get edit_recipe_path(@recipe)
      assert_template 'recipes/edit'
      patch recipe_path(@recipe), params: { recipe: { name: " ", email: " some description" } }
      assert_template 'recipes/edit'
      assert_select 'h2.panel-title'
      assert_select 'div.panel-body'

    end

    test "successfully edit a recipe" do
      get edit_recipe_path(@recipe)
      assert_template 'recipes/edit'
      updated_name = "updated recipe name"
      updated_description = "updated description"
      patch recipe_path(@recipe), params: { recipe: {name: updated_name, email: updated_description}}
      assert_redirected_to @recipe
      #follow redirect!
      assert_not flash.empty?
      @recipe.reload
      assert_match updated_name, @recipe.name
      assert_match updated_description, @recipe.email



    end


end

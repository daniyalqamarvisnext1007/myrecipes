require "test_helper"

class ChefsListingTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "daniyal", email: "dani@gmail.com",
                          password: "password", password_confirmation: "password")

    @chef2 = Chef.create!(chefname: "daniyal", email: "dani@gmail.com",
                          password: "password", password_confirmation: "password")
    
  end


  test "should get chef listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.capitalize
  end


  test "should delete chef" do
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end


end

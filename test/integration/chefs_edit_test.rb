require "test_helper"

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "daniyalqamar", email: "hello@gmail.com",
                        password: "password", password_confirmation: "password")
  end

  test "reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chefs_path, params: { chef: { chefname: " ", email: "daniyal@visnext.com"}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chefs_path, params: { chef: { chefname: "daniyal1", email: "daniyal1@visnext.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "daniyal1", @chef.chefname
    assert_match "daniyal1@visnext.com", @chef.email
  end

end

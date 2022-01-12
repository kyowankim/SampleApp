require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
   
  def setup  
    @user = users(:michael)
  end

  test "users unsuccesful edit" do 
    get edit_user_path(@user)
    log_in_as(@user)
    patch user_path(@user), params: { user: { name: "", email: "", password: "pass", password_confirmation: "word"}}
    assert_template 'users/edit'
  end

  test "user successful edit" do 
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "Tom Kim"
    email = "tomkim@gmail.com"
    patch user_path(@user), params: { 
                                  user: { 
                                    name: name, 
                                    email: email, 
                                    password: "", 
                                    password_confirmation: "" }}
    assert_not flash.empty? 
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

end

module FeatureHelpers
  # Put helper methods you need to be available in all acceptance specs here.
  def create_user(email, password='secret')
    @user = User.find_by_email(email) || FactoryGirl.create(:user, email: email, password: password)
  end

  def login_as(email)
    visit "/users/sign_in"
    fill_in "user_email", with: email
    fill_in "user_password", with: "secret"
    submit_form
  end

  def submit_form
    find("[type=submit]").click
  end

  def homepage
    "/"
  end
end

feature "User Adds Company" do


  scenario "logged out users can't add companies" do
    visit root_path
    page.should_not have_content("Add a Company")
  end

  before do
    visit new_user_session_path
  end


  scenario "happy path" do
    user = Fabricate(:user, name: "Jenny")
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    page.should have_content("Add a Company")
    click_on "Add a Company"
    fill_in "Name", with: "Centresource"
    fill_in "Url", with: "www.centresource.com"
    click_button "Add Company"
    current_path.should == companies_path
    page.should have_content("Centresource has now been added.")
    page.should have_link "Centresource"
    click_on "Centresource"
    page.should have_content("www.centresource.com")
    page.should have_link("Edit Company")
  end

  scenario "sad path" do
    user = Fabricate(:user, name: "Jenny")
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    click_link "Add a Company"
    fill_in "Name", with: ""
    fill_in "Url", with: ""
    click_button "Add Company"
    page.should have_content("Company could not be saved. Please fix the errors to continue.")
    page.should have_error("can't be blank", on: "Name")
    page.should have_error("can't be blank", on: "Url")
  end
end

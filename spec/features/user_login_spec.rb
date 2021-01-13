require 'rails_helper'

RSpec.feature "User can login", type: :feature, js: true do

  before :each do
    @user = User.new(first_name: "Maria", last_name: "Bucar", email: "mariabucar@email.com", password: "password", password_confirmation: "password")
    @user.save!
  end

  scenario "They can login with their email and password" do
    # ACT
    visit root_path
    first("nav.navbar").find_link('User').click
    find_link('Login').click
    fill_in "email", with: "mariabucar@email.com"
    fill_in "password", with: "password"
    find_button('Submit').click
    expect(page).to have_content "Signed in as Maria"
  end
end
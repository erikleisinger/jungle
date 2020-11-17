require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user1 = User.create!(
      name: 'Erik',
      email: 'erik@erik.com',
      password: '12345678',
      password_confirmation: '12345678'
    )
  end

  scenario 'can log into the site' do
    visit login_path
    puts page.html
    fill_in('email', :with => 'erik@erik.com')
    fill_in('password', :with => '12345678')

    find('input[name="commit"]').click

    expect(page).to have_text("Logout")
  end
end

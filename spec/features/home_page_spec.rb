require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  before :each do 
    @category = Category.create! name: "Apparel"

    10.times do
      @category.products.create!(
        name: Faker::Hipster.sentence(2),
        description: Faker::Hipster.paragraph(3),
        quantity: 10,
        price: 69.69,
        image: open_asset('apparel1.jpg'),
      )
    end
  end

  scenario "They see all products" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    save_screenshot 'home_page1.png'

    expect(page).to have_css 'article.product', count: 10
  end

end
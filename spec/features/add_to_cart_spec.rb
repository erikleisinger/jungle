require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "it adds an item to the cart" do
    visit root_path
    expect(page).to have_text('My Cart (0)')
    find('button', text: 'Add', match: :first).click
    expect(page).to have_text('My Cart (1)')
  end
end

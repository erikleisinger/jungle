require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js:true do
  
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

  scenario 'Clicking on a details button shows product details' do

  visit root_path

  find_link('Details', match: :first).click



  expect(page).to have_css 'section.products-show', wait: 10
  save_screenshot 'details1.png'

 
  end


end

require 'rails_helper'

RSpec.feature "Visitor adds an item to their cart", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can add 1 of a product to their cart by clicking on the add button" do
    # ACT
    visit root_path
    first("article.product").find_button('Add').click
    expect(page).to have_content "My Cart (1)"
    # sleep 3 
    # save_screenshot
  end
end
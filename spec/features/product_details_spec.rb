require 'rails_helper'

RSpec.feature "Visitor navigates to products page", type: :feature, js: true do
  
  # SETUP

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the products details" do
    # ACT
    visit root_path
    expect(page).to have_css 'article.product'

    visit 'products/1'

    expect(page).to have_css '.products-show'
    expect(page).to have_css '.product-detail'
  end

end
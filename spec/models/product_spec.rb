require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:each) do
    Product.destroy_all
    Category.destroy_all
    @category = Category.create!(name: 'Rats')
    @subject = @category.products.create!(
      :name => 'Fat Rat',
      :price => 6500,
      :quantity => 1
    )
  end
  

  describe 'Associations' do
    it 'should belong to category' do
      expect(subject).to have_attributes(:category => anything)
    end
  end

  describe 'Validations' do

    it 'is valid with valid attributes' do
      expect(@subject).to be_valid
    end

    it 'should have a name' do
     expect(@subject).to have_attributes(:name => 'Fat Rat')
    end

    it 'should have a price' do
      expect(@subject).to have_attributes(:price => 6500)
    end

    it 'should have a quantity' do
      expect(@subject).to have_attributes(:quantity => 1)
    end

    it 'should be invalid with a name of nil' do
      @subject.name = nil
      expect(@subject).to_not be_valid
    end

    it 'should be invalid with a price of nil' do
      @subject.price_cents = nil;
      expect(@subject).to_not be_valid
    end

    it 'should be invalid with a quantity of nil' do
      @subject.quantity = nil;
      expect(@subject).to_not be_valid
    end

    it 'should have an error when invalid' do
      @subject.name = nil;
      @subject.save
      expect(@subject.errors.full_messages).to contain_exactly "Name can't be blank"
    end
  end
end

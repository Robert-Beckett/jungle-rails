class Admin::CategoriesController < ApplicationController

  def destroy
    @category = Category.find params[:id]
    @category.destroy
    redirect_to [:admin], notice: 'Category deleted!'
  end
end

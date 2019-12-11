class CategoriesController < ApplicationController
  http_basic_authenticate_with name: Rails.configuration.admin[:admin_name], 
                               password: Rails.configuration.admin[:admin_pass], only: :destroy

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
  end

end
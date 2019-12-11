class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: Rails.configuration.admin[:admin_name], 
                               password: Rails.configuration.admin[:admin_pass]

  def show
    @productCount = Product.count(:id)
    @categoryCount = Category.count(:id)
    @categories = Category.order(id: :asc).all
  end

  def destroy
    @category = Category.find params[:id]
    @category.destroy
    redirect_to [:admin], notice: 'Category deleted!'
  end
end

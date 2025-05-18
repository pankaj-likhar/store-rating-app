class AdminController < ApplicationController
  before_action :authorize_admin
  
  def dashboard
    @total_users = User.count
    @total_stores = Store.count
    @total_ratings = Rating.count
  end
end

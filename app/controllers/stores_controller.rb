class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, except: [:index, :show]
  
  def index
    if current_user.system_admin?
      @stores = Store.all
    elsif current_user.store_owner?
      @stores = Store.where(owner_id: current_user.id)
    else
      @stores = Store.all 
    end
  end

  def show
    @rating = Rating.new
    @ratings = @store.ratings.includes(:user).order(created_at: :desc)
  end
  
  def new
    @store = Store.new
  end
  
  def create
    @store = Store.new(store_params)
    
    if @store.save
      redirect_to @store, notice: 'Store was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @store.update(store_params)
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @store.destroy
    redirect_to stores_path, notice: 'Store was successfully destroyed.'
  end
  
  private
  
  def set_store
    @store = Store.find(params[:id])
  end
  
  def store_params
    params.require(:store).permit(:name, :email, :address, :owner_id)
  end
end

class RatingsController < ApplicationController
  before_action :set_store
  before_action :set_rating, only: [:edit, :update]

  def create
    @rating = @store.ratings.build(rating_params)
    @rating.user = current_user

    if @rating.save
      redirect_to @store, notice: 'Rating was successfully created.'
    else
      redirect_to @store, alert: @rating.errors.full_messages.join(', ')
    end
  end

  def edit
  end

  def update
    if @rating.update(rating_params)
      redirect_to @store, notice: 'Rating was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end

  def set_rating
    @rating = @store.ratings.find_by(id: params[:id], user_id: current_user.id)
    redirect_to @store, alert: "Not authorized" unless @rating
  end

  def rating_params
    params.require(:rating).permit(:value, :comment)
  end
end

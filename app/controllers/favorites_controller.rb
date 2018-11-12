class FavoritesController < ApplicationController

  before_action :authenticate_user!

  load_and_authorize_resource only: [:destroy], class: 'UserFavorite'

  def create
    record = Record.find(params[:id])
    @favorite = UserFavorite.new(user: current_user, record: record)

    if @favorite.save
      redirect_back fallback_location: root_path, notice: "#{record.title} was added to your favorites."
    else
      redirect_back fallback_location: root_path, alert: @favorite.errors.full_messages
    end
  end

  def destroy
    title = @favorite.record.title

    if @favorite.destroy
      redirect_back fallback_location: root_path, notice: "#{title} was removed from your favorites."
    else
      redirect_back fallback_location: root_path, alert: @favorite.errors.full_messages
    end
  end

end

class Admin::HomesController < ApplicationController
  def edit
    @home = Home.find(params[:id])
  end
end

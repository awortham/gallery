class AddressesController < ApplicationController

  def create
    @address = Address.create(address_params)
    redirect_to new_order_path(business.slug, address: @address.id)
  end

  private

  def address_params
    params.require(:address).permit(:user_id, :street_number, :street, :city, :state, :zip)
  end
end

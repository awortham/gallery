class ApplicationController < ActionController::Base
  attr_accessor :business

  protect_from_forgery with: :exception
  include UsersHelper

  before_action :set_user
  before_action :set_business

  helper_method :cart
  helper_method :find_item
  helper_method :address_delivered_to
  helper_method :order_items
  helper_method :past_order_quantity
  helper_method :past_order_total
  helper_method :user_admin?
  helper_method :line_item_subtotal

  def cart
    @cart ||= Cart.new(session)
  end

  def find_item(item_id)
    Item.find(item_id)
  end

  def order_items(line_items_hash)
    items = {}
    line_items_array = line_items_hash.to_a
    line_items_array.each do |id_and_item_array|
      item_id = id_and_item_array[0].scan(/\d+/)
      quantity = id_and_item_array[1].to_i
      items[item_id[0]] = quantity
    end
    items
  end

  def past_order_quantity(line_items_hash)
    order_items(line_items_hash).values.reduce(0) {|sum, quantity| sum += quantity}
  end

  def past_order_total(line_items_hash)
    total = 0
    order_items(line_items_hash).each do |item_id, quantity|
      total += find_item(item_id).price * quantity
    end
    total
  end

  def line_item_subtotal(item_id, quantity)
    find_item(item_id).price *  quantity
  end

  def past_order_quantity(line_items_hash)
    order_items(line_items_hash).values.reduce(0) {|sum, quantity| sum += quantity}
  end

  private
    def set_user
      @user = User.new
    end

    def set_business
      @business = Business.where(slug: params[:store_slug]).first
    end
end

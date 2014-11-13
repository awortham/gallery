class ApplicationController < ActionController::Base
  attr_reader :business
  attr_reader :cart

  protect_from_forgery with: :exception
  include UsersHelper

  before_action :set_user
  before_action :set_cart
  before_action :set_business
  before_action :ensure_member
  before_action :ensure_status

  helper_method :cart
  helper_method :find_item
  helper_method :address_delivered_to
  helper_method :order_items
  helper_method :past_order_quantity
  helper_method :past_order_total
  helper_method :user_admin?
  helper_method :line_item_subtotal
  helper_method :business

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
    def ensure_member
      if current_user && current_user.business_id != business.id && current_user.platform_admin == false
        session.clear
        redirect_to(request.original_url)
      end
    end

    def set_user
      @user = User.new
    end

    def set_business
      @business = Business.where(slug: params[:store_slug]).first
    end

    def ensure_status
      redirect_to platform_path('gallery') if business.status == "retired"
    end

    def set_cart
      @cart = current_user ? current_user.cart : session[:cart_id] ? Cart.find(session[:cart_id]) : Cart.create
    rescue ActiveRecord::RecordNotFound
      Cart.create
    ensure
      session[:cart_id] ||= @cart.id
    end
end

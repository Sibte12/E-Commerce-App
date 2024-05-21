class CartsController < ApplicationController
    def show
        @cart_items = current_cart.cart_items
    end

    def remove_item
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        redirect_to cart_path, notice: "Item removed from cart."
    end

end

class ApplicationController < ActionController::Base

    before_action :set_current_cart

    private

    def set_current_cart
    if user_signed_in?
        @current_cart = current_user.cart || current_user.build_cart
    else
        @current_cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] ||= @current_cart.id
    end
    end

    def current_cart
    @current_cart
    end

end

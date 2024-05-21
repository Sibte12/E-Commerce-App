class CheckoutController < ApplicationController
    def show
        @order = current_user.orders.find_by(status: "in_progress")

        if @order.nil?
        # If no order in progress, build a new one
        @order = current_user.orders.build
        else
        # If an order in progress exists, use that order
        @cart_items = @order.user.cart.cart_items
        @total_price = @order.total_amount
        end
        @cart_items = current_user.cart.cart_items
        @total_price = calculate_total_price(@cart_items)
    end

    def create
        @order = current_user.orders.build(user_id: current_user.id, total_amount: session[:discounted_price] || calculate_total_price(current_user.cart.cart_items))
        
        if @order.save
        current_user.cart.cart_items.each do |cart_item|
        product = cart_item.product
        product.update(stock: product.stock - cart_item.quantity)
        end
        current_user.cart.cart_items.destroy_all
        redirect_to order_placed_path, notice: 'Order placed successfully.'
        else
        puts @order.errors.full_messages
        render :show
        end
    end

    def apply_promo_code
        
        puts "Finding promo code..."
        promo_code = PromoCode.find_by(code: params[:promo_code])
        puts "Building order..."
        @order ||= current_user.orders.build(user_id: current_user.id, total_amount: calculate_total_price(current_user.cart.cart_items))
        
        if promo_code.present? && promo_code.valid_til >= Date.today
            puts "Calculating total price..."
            @total_price = calculate_total_price(current_user.cart.cart_items)
            
            puts "Calculating discount amount..."
            discount_amount = calculate_discount(promo_code, @total_price)
            
            puts "Applying discount..."
            @total_price -= discount_amount
            
            puts "Updating order total amount..."
            @order.total_amount = @total_price
            @order.save
            puts "Redirecting to checkout path..."
            puts "@order total amount: #{@order.total_amount}"
            flash[:success] = "Promo code applied successfully."
            @cart_items = current_user.cart.cart_items
            
            redirect_to checkout_path
        else
            @order.total_amount = @total_price
            puts "Invalid or expired promo code."
            flash[:error] = "Invalid or expired promo code."
            puts @order.errors.full_messages
            
            puts "Rendering checkout page..."
            @cart_items = current_user.cart.cart_items
            render :show
        end
    end
    
    
    

    private

    def calculate_total_price(cart_items)
        total_price = 0
        cart_items.each do |cart_item|
          total_price += cart_item.quantity * cart_item.product.price
        end
        total_price
    end

    def calculate_discount(promo_code, total_price)
        (total_price * promo_code.discount_percentage / 100).round(2)
    end
end
    

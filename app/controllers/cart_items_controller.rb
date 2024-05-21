class CartItemsController < ApplicationController

    def create
        product = Product.find(params[:product_id])
        @cart_item = current_cart.cart_items.new(product: product)
    
        if @cart_item.save
        redirect_to products_path, notice: 'Product added to cart successfully.'
        else
        redirect_to products_path, alert: 'Failed to add product to cart.'
        end
    end
    def update
        @cart_item = CartItem.find(params[:id])
        new_quantity = params[:quantity].to_i
        
        # Ensure the new quantity doesn't exceed the stock value
        if new_quantity <= @cart_item.product.stock
        @cart_item.update(quantity: new_quantity)
        render json: { quantity: @cart_item.quantity }
        else
        render json: { error: 'Quantity exceeds stock limit' }, status: :unprocessable_entity
        end
    end

    

end

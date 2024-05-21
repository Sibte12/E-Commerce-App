class ProductsController < ApplicationController
    
    def index
            @products = Product.all
    end
    def show
        @product = Product.find(params[:id])
        @comments = @product.comments
    end
    def new
        @product = Product.new
    end

    def create
        @product = current_user.products.build(product_params)
        if @product.save
        redirect_to @product, notice: "Product created successfully."
        else
        puts @product.errors.full_messages
        render :new
        end
    end

    before_action :authenticate_user!
    private

def product_params
    params.require(:product).permit(:name, :price, :stock)
end
end

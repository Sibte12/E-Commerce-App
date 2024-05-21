class CommentsController < ApplicationController
    def create
        @product = Product.find(params[:product_id])
        @comment = @product.comments.build(content: params[:content])
        @comment.user = current_user
        if current_user != @product.user && @comment.save
          render json: { success: true, comment: @comment }
        else
          puts @comment.errors.full_messages
          render json: { success: false }
        end
      end
end

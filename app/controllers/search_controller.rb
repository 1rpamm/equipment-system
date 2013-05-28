class SearchController < ApplicationController
  def search
    @post = Post.search {
      keywords params[:query]
      order_by :created_at, :asc
    }.results
    render 'posts/index'
  end
end

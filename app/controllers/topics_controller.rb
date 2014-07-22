class TopicsController < ApplicationController
  respond_to :atom

  def index
    @topics = Topic.order(:created_at).reverse_order.limit(5)
  end
end

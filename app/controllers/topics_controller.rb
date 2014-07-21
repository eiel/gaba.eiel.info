class TopicsController < ApplicationController
  respond_to :atom

  def index
    @site_title = 'とある我馬の非公式ファンサイト'
    @site_description = 'ラーメン屋我馬を応援する情報を発信します。'
    @topics = Topic.order(:created_at).reverse_order.limit(5)
  end
end

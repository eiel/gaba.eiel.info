class Topic < ActiveRecord::Base

  after_save do
    begin
      twitter_client.update "我馬のサイトに更新があるね > #{title} #{url}"
    rescue Twitter::Error::Forbidden => e
      Rails.logger.info("tweet error: " + e.message)
    end
  end

  def self.create_topic_from_website
    Gaba.new.to_hash.each do |topic|
      find_or_create_by!(id: topic[:artcile_id],
                         title: topic[:title],
                         created_at: topic[:date])
    end
  end

  def url
    "http://www.gaba-2000.com/news.php?q=#{id}"
  end

  def content
    <<STRING
<h1>我馬のサイトに更新がありました。<h1>
<p><a href="#{url}" title="#{title}"}>#{title}</a></p>
STRING
  end

  def entry_id
    "topics/#{id}"
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end
end

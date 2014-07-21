class Topic < ActiveRecord::Base

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
end

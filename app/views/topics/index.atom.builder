atom_feed(:language => 'ja-JP',
          :root_url => @site_url,
          :url      => @atom_url,
          :id       => @site_url) do |feed|
  feed.title    @site_title
  feed.subtitle @site_description
  feed.updated  Time.now
  feed.author{|author| author.name(@author) }

  @topics.each do |topic|
    feed.entry(topic,
               url:       topic.url,
               id:        topic_url(topic),
               published: topic.created_at,
               updated:   topic.created_at) do |item|
      item.title(topic.title)
      item.content(topic.content, :type => 'html')
      item.author{|author| author.name(@author) }
    end
  end
end
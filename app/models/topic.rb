class Topic < ActiveRecord::Base

  def self.create_topic_from_website
    Gaba.new.to_hash.each do |topic|
      find_or_create_by!(id: topic[:artcile_id],
                         title: topic[:title],
                         created_at: topic[:date])
    end
  end
end

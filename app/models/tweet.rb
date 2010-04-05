include Twitter
class Tweet
  def self.messages_for(phrase,limit=4)
    tweets = []
    search = Twitter::Search.new("#{phrase}")
    search.each do |r|
      tweets << r
    end
    return tweets[0..limit]
  end
end

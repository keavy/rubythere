include Twitter
class Tweet
  def self.messages_for(phrase,limit=5)
    tweets = []
    search = Twitter::Search.new.q("#{phrase}").fetch
    search.each do |r|
      tweets << r
    end
    return tweets[0..limit-1]
  rescue SocketError
    []
  end
end

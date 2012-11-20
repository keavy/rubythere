class Tweet
  def self.messages_for(phrase,limit=5)
    search = Twitter.search("#{phrase} -rt", :count => limit)
    search.results
  rescue SocketError
    []
  end
end

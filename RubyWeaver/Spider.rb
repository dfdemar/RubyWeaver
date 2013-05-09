require_relative "NetworkConnection"

class Spider
  def initialize()
    @url_queue = []
  end
  
  def go(url)
    source = fetch_new_page(url)
    crawl(source)
    load_next_url()
  end
  
  private
  
  def fetch_new_page(url)
    puts "Loading #{url}"
    NetworkConnection.connect(url)
  end
  
  def crawl(source)
    links = source.scan(/href="(http.+?)"/)
    links.each do |link|
      @url_queue.push(link[0])
      puts "Link found - #{link[0]}"
    end
  end
  
  def load_next_url()
    while @url_queue.any? do
      go(@url_queue.shift)
    end
  end
end
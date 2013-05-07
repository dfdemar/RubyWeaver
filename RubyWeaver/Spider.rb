require_relative "NetworkConnection"

class Spider
  def initialize()
    @url_queue = []
  end
  
  def go(url)
    fetch_new_page(url)
  end
  
  private
  
  def fetch_new_page(url)
    puts "Loading #{url}"
    source = NetworkConnection.connect(url)
    crawl(source)
  end
  
  def crawl(source)
    links = source.scan(/(href|src)="(http.+?)"/)
    links.each do |link|
      @url_queue.push(link[1])
      puts "- #{link[1]}"
    end
    
    load_next_url()
  end
  
  def load_next_url()
    while @url_queue.any? do
      fetch_new_page(@url_queue.shift)
    end
  end
end
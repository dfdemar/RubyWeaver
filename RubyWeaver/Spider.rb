require_relative "NetworkConnection"
require_relative "SpiderController"

class Spider
  def initialize()
    @controller = SpiderController.new()
    @url_queue = []
    @urls_seen = []
  end
  
  def go(url)
    @urls_seen.push(url)
    process(url)
  end

  private
  
  def process(url)
    source = fetch_new_page(url)
    if !source.empty? or !source.nil?
      crawl(source)
    end
    load_next_url()
  end

  def fetch_new_page(url)
    puts "Loading #{url}"
    source = NetworkConnection.connect(url)
  end
  
  def crawl(source)
    links = source.scan(/href="(http.+?)"/)
    links.each do |link|
      puts "Link found - #{link[0]}"
      handle_URL(link[0])
    end
  end
  
  def handle_URL(url)
    if @urls_seen.include?(url)
      puts "Skipping this URL - #{url}"
    else
      @url_queue.push(url)
      @urls_seen.push(url)
      puts "Queuing - #{url}"
    end
  end
  
  def load_next_url()
    while @url_queue.any? do
      go(@url_queue.shift)
    end
  end
end
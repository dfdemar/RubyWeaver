require_relative "NetworkConnection"

class Spider
  def initialize()
    @variable = ""
  end
  
  def go(url)
    fetch_new_page(url)
  end
  
  def fetch_new_page(url)
    NetworkConnection.connect(url)
  end
end
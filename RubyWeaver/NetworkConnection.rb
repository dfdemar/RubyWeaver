require "net/http"
require "uri"

module NetworkConnection
  
  module_function
  def connect(url)
    get_response(url)
  end
  
  def get_response(url)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    response.body()
  end
end
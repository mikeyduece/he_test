class Brewery
  BASE_URL = 'https://api.openbrewerydb.org/breweries'.freeze
  private_constant :BASE_URL
  
  def list(options = {})
    get_url(options: options)
  end
  
  def find(id:)
    get_url(url: "#{BASE_URL}/#{id}")
  end
  
  def search(query:, options: {})
    url = "#{BASE_URL}/search?query=#{query}"
    
    get_url(url: url, options: options)
  end
  
  private
  
  def get_url(url: nil, options: {})
    connection.params = options
    response          = connection.get(url)
    
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def connection
    @connection ||= Faraday.new(url: BASE_URL) { |faraday| faraday.adapter Faraday.default_adapter }
  end
end
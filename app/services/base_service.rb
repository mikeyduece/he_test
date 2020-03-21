class BaseService
  
  def initialize(query = {}, url = nil, options = {})
    @query   = query
    @url     = url
    @options = options
  end
  
  private_class_method :new
  
  private
  
  attr_reader :query, :url, :options
  
  def client
    @client ||= BreweryAPI.new
  end
end
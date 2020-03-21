class BaseService
  def initialize(query = {}, url = nil)
    @query   = query
    @url     = url
  end
  
  private_class_method :new
  
  private
  
  attr_reader :query, :url
  
  def client
    @client ||= BreweryAPI.new
  end
end
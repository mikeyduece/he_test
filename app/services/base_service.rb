class BaseService
  
  def initialize(query: nil)
    @query = query
  end
  
  private_class_method :new
  
  private
  attr_reader :query
  
  def client
    @client ||= BreweryAPI.new
  end
end
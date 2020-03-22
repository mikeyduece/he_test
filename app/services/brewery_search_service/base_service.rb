module BrewerySearchService
  class BaseService
    def initialize(query = {}, url = nil)
      @query = sliced_query_params(query)
      @url   = url
    end
    
    private_class_method :new
    
    def self.call(query = {}, url = :list, &block)
      new(query, url).call(&block)
    end
    
    def call(&block)
      create_search_if_required
      breweries = client.send(url, search.query)
      
      yield(Success.new(breweries), NoTrigger)
    
    rescue StandardError => e
      yield(NoTrigger, Failure.new(e.message))
    end
    
    private
    
    attr_reader :query, :url, :search
    
    def sliced_query_params(query_params)
      query_params.slice(:by_type, :by_city, :by_state, :by_tags, :by_name, :page, :per_page)
    end
    
    # Finds or creates a query based on the user input. Ensuring that the query is unique
    def create_search_if_required
      @search ||= Search.find_or_create_by(query: query)
    end
    
    def client
      @client ||= BreweryAPI.new
    end
  end
end
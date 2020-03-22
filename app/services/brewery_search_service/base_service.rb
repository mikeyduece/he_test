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
      raise Search::InvalidQueryParams unless authorized_params?
      
      create_search_if_required
      breweries = client.send(url, search.query)
      
      yield(Success.new(breweries), NoTrigger)
    
    rescue Search::InvalidQueryParams => e
      yield(NoTrigger, Failure.new(e))
    rescue StandardError => e
      yield(NoTrigger, Failure.new(e))
    end
    
    private
    
    attr_reader :query, :url, :search
    
    def sliced_query_params(query_params)
      query_params.slice(:by_type, :by_city, :by_state, :by_tags, :by_name, :page, :per_page, :id)
    end
    
    def authorized_params
      %i[by_type by_city by_state by_tags by_name page per_page id]
    end
    
    def authorized_params?
      !(query.keys & authorized_params).empty? || query.keys.empty?
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
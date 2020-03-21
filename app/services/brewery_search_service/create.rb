module BrewerySearchService
  class Create < BaseService
    
    def self.call(query, url = :list, &block)
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
    
    attr_reader :search
    
    # Finds or creates a query based on the user input. Ensuring that the query is unique
    def create_search_if_required
      @search ||= Search.find_or_create_by(query: query)
    end
  end
end
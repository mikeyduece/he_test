module BrewerySearchService
  class Create < BaseService
    
    def self.call(query, url = :list, &block)
      new(query, url).call(&block)
    end
    
    def call(&block)
      create_search_if_required
      breweries = client.send(url, query)
      
      yield(Success.new(breweries), NoTrigger)
    
    rescue StandardError => e
      yield(NoTrigger, Failure.new(e.message))
    end
    
    private
    
    def create_search_if_required
      search = Search.new(query: query)
      search.save!
    end
  end
end
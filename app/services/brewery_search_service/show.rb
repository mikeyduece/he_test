module BrewerySearchService
  class Show < BaseService
    def call(&block)
      create_search_if_required
      brewery = client.send(url, id: query[:id])
    
      yield(Success.new(brewery), NoTrigger)
  
    rescue Search::InvalidQueryParams => e
      yield(NoTrigger, Failure.new(e))
    rescue StandardError => e
      yield(NoTrigger, Failure.new(e))
    end
    
  end
end
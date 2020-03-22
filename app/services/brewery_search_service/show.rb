module BrewerySearchService
  class Show < BaseService
    def call(&block)
      create_search_if_required
      breweries = client.send(url, id: query[:id])
    
      yield(Success.new(breweries), NoTrigger)
  
    rescue StandardError => e
      yield(NoTrigger, Failure.new(e.message))
    end
  end
end
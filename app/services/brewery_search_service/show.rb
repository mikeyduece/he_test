module BrewerySearchService
  class Show < BaseService
    def call(&block)
      create_search_if_required
      brewery = client.send(url, id: query[:id])
    
      yield(Success.new(brewery), NoTrigger)
  
    rescue StandardError => e
      yield(NoTrigger, Failure.new(e.message))
    end
  end
end
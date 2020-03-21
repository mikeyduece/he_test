module BrewerySearchService
  class Create < BaseService
    
    def self.call(query, url = nil, options = {}, &block)
      new(query, url, options).call(&block)
    end
    
    def call(&block)
      search = Search.new(query: query)
      search.save!
      
      yield(Success.new(search), NoTrigger)
    
    rescue StandardError => e
      yield(NoTrigger, Failure.new(e.message))
    end
  end
end
module BrewerySearchService
  class Create < BaseService
    
    def self.call(query, &block)
      new(query).call(&block)
    end
    
    private
    
    def call(&block)
      search = Search.new(query: query)
      search.save!
      
      yield(Success.new(search), NoTrigger)
      
    rescue StandardError => e
      yield(NoTrigger, Failure.new(e.full_messages.first))
    end
  end
end
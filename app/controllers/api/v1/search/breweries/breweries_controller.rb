class Api::V1::Search::Breweries::BreweriesController < ApplicationController

  def index
    BrewerySearchService::Index.call do |success, failure|
      success.call do |resource|
        success_response(200, breweries: serialized_response(resource, Breweries::BreweryBlueprint, view: :extended))
      end
      
      failure.call { |error| error_response(404, error) }
    end
  end
  
end
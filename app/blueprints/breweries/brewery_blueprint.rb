module Breweries
  class BreweryBlueprint < BaseBlueprint
    identifier :id
    
    view :normal do
      fields :name
    end
    
    view :extended do
      fields :name, :brewery_type, :street, :city, :state, :postal_code, :website_url, :phone
    end
  end
end
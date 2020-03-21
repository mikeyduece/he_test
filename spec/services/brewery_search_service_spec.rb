require 'rails_helper'

RSpec.describe 'BrewerySearchService' do
  it 'should create a Search for new queries' do
    use_cassette('list_with_params') do
      BrewerySearchService::Create.call(query: { by_city: 'Denver' }) do |success, failure|
        expect(success).not_to be_nil
        expect(success.resource).to be_a(Search)
        expect(success.all? { |h| h[:city] = 'Denver' }).to be_truthy
        
        expect(failure).to be_nil
      end
      
      search = Search.find_by('query @> ?', { city: 'Denver' })
      
      expect(search).not_to be_nil
    end
  end
end
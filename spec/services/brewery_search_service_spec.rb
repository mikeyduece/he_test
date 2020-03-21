require 'rails_helper'

RSpec.describe 'BrewerySearchService' do
  it 'should create a Search for new queries' do
    use_cassette('list_with_params') do
      BrewerySearchService::Create.call({ by_city: 'Denver' }) do |success, _failure|
        success.call do |resource|
          expect(resource).to be_a(Array)
          expect(resource.first).to be_a(Hash)
          expect(resource.all? { |h| h[:city].eql?('Denver') })
        end
      end
      
      search = Search.find_by('query @> ?', { by_city: 'Denver' }.to_json)
      
      expect(search).not_to be_nil
      expect(Search.count).to eq(1)
    end
  end
  
  it 'should reuse queries that match in the DB' do
    2.times do
      BrewerySearchService::Create.call({ by_city: 'Denver' }) do |success, _failure|
        success.call { |resource| expect(resource).to be_a(Array) }
      end
    end
    
    expect(Search.count).to eq(1)
  end

  it 'should create new search for new query' do
    BrewerySearchService::Create.call({ by_city: 'Denver' }) do |success, _failure|
      success.call { |resource| expect(resource).to be_a(Array) }
    end

    BrewerySearchService::Create.call({ by_city: 'Boston' }) do |success, _failure|
      success.call { |resource| expect(resource).to be_a(Array) }
    end
    
    expect(Search.count).to eq(2)
  end
end
require 'rails_helper'

RSpec.describe 'BrewerySearchService' do
  subject { BrewerySearchService::Create.new({by_city: 'Denver'}) }
  
  it 'should return a service object' do
    expect(subject).to be_a(BrewerySearchService::Create)
  end
  
  it 'should create a Search for new queries' do
    use_cassette('list_with_params') do
      search           = Search.find_by('query @> ?', { city: 'Denver' })
      
      expect(subject).not_to be_empty
      expect(subject.all? { |h| h[:city] = 'Denver' }).to be_truthy
      expect(search).not_to be_nil
    end
  end
end
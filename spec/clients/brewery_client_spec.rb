require 'rails_helper'

RSpec.describe 'Brewery DB Client' do
  subject { BreweryAPI.new }
  
  it 'is a BreweryAPI object' do
    expect(subject).to be_a(BreweryAPI)
  end
  
  it '#list' do
    use_cassette('brew_list') do
      @breweries                   = subject.list
      @first_page_first_brewery_id = @breweries.first[:id]
    end
    
    use_cassette('second_page_breweries') do
      @breweries_2                  = subject.list(page: 2)
      @second_page_first_brewery_id = @breweries_2.first[:id]
    end
    
    
    expect(@breweries.count).to eq(20)
    expect(@first_page_first_brewery_id).not_to eq(@second_page_first_brewery_id)
  end

  it 'should #list with params' do
    use_cassette('list_with_params') do
      breweries = subject.list(by_city: 'Denver')
      
      expect(breweries).not_to be_empty
      expect(breweries.all? { |h| h[:city] = 'Denver' }).to be_truthy
    end
  end
  
  it '#find' do
    use_cassette('find_brewery_2') do
      brewery = subject.find(id: 2)
      
      expect(brewery[:id]).to eq(2)
      expect(brewery[:name]).to eq('Avondale Brewing Co')
      expect(brewery[:name]).not_to eq('Comrade Brewing Co')
    end
  end
  
  it '#search' do
    use_cassette('search_breweries') do
      breweries = subject.search(query: 'Comrade')
      
      expect(breweries).not_to be_empty
      expect(breweries.any? { |h| h[:name] =~ /Comrade/ }).to be_truthy
    end
  end

end
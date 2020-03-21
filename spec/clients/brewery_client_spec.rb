require 'rails_helper'

RSpec.describe 'Brewery DB Client' do
  subject { Brewery.new }
  
  it 'is a Brewery object' do
    expect(subject).to be_a(Brewery)
  end

  it '#list' do
    VCR.use_cassette('brew_list', allow_playback_repeats: true) do
      @breweries = subject.list
      @first_page_first_brewery_id = @breweries.first[:id]
    end
    
    VCR.use_cassette('second_page_breweries', allow_playback_repeats: true) do
      @breweries_2 = subject.list(page: 2)
      @second_page_first_brewery_id = @breweries_2.first[:id]
    end
    
    
    expect(@breweries.count).to eq(20)
    expect(@first_page_first_brewery_id).not_to eq(@second_page_first_brewery_id)
  end

  it '#find' do
    use_cassette('find_brewery_2') do
      brewery = subject.find(id: 2)
      require 'pry'; binding.pry
    end
  end
end
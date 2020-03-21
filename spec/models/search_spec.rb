require 'rails_helper'

RSpec.describe Search, type: :model do
  context :validations do
    it 'should validate uniqueness' do
      search_1      = Search.create(query: { city: 'Denver', tags: ['patio', 'food-truck'] })
      search_2      = Search.new(query: { city: 'Denver', tags: ['patio', 'food-truck'] })
      error_message = search_2.errors.full_messages.first
      
      expect(search_1).to be_valid
      expect(search_2).not_to be_valid
      expect(error_message).to eq('Search with these params already exists')
    end
    
    it 'should allow for different queries' do
      search_1 = Search.new(query: { city: 'Denver', tags: ['patio', 'food-truck'] })
      search_2 = Search.new(query: { city: 'Boulder', tags: ['patio', 'food-truck'] })
      
      expect(search_1).to be_valid
      expect(search_2).to be_valid
    end
  end

end

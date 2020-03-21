require 'rails_helper'

RSpec.describe Search, type: :model do
  context :validations do
    it 'should validate uniqueness' do
      search_1      = Search.create(query: { by_city: 'Denver', by_tags: ['patio', 'food-truck'] })
      search_2      = Search.new(query: { by_city: 'Denver', by_tags: ['patio', 'food-truck'] })
      
      expect(search_1).to be_valid
      expect(search_2).not_to be_valid
    end
    
    it 'should allow for different queries' do
      search_1 = Search.new(query: { by_city: 'Denver', by_tags: ['patio', 'food-truck'] })
      search_2 = Search.new(query: { by_city: 'Boulder', by_tags: ['patio', 'food-truck'] })
      
      expect(search_1).to be_valid
      expect(search_2).to be_valid
    end
  end

end

class Search < ApplicationRecord
  store_accessor :query, :by_type, :by_city, :by_state, :by_tags, :by_name
  
  validates :query, presence: true
  validate :ensure_unique_query, on: :create
  
  private
  
  def ensure_unique_query
    errors[:base] << 'Search with these params already exists' if self.class.exists?(query: self.query)
  end
end

class Search < ApplicationRecord
  store_accessor :query, :types, :city, :state, :tags, :name
  
  validates :query, presence: true
  validate :ensure_unique_query, on: :create
  
  private
  
  def ensure_unique_query
    errors[:base] << 'Search with these params already exists' if self.class.exists?(query: self.query)
  end
end

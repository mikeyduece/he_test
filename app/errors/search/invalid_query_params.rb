class Search::InvalidQueryParams < Base
  
  def status
    404
  end
  
  def message
    'Please only use the following query params: [:by_type, :by_city, :by_state, :by_tags, :by_name, :page, :per_page, :id]'
  end
end
class Success
  attr_reader :resource
  
  def intialize(resource = nil)
    @resource = resource
  end
  
  def call
    yield(resource)
  end
end
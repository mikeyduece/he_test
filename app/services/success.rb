class Success
  attr_reader :resource
  
  def initialize(resource = nil)
    @resource = resource
  end
  
  def call
    yield(resource)
  end
end
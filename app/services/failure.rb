class Failure
  attr_reader :error
  
  def initialize(error)
    @error = error
  end
  
  def call
    yield(error)
  end
end
class Failure
  attr_reader :error
  
  def intialize(error)
    @error = error
  end
  
  def call
    yield(error)
  end
end
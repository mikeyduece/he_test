module BlueprintHelper
  
  def serialized_response(resource, blueprint, options = {})
    blueprint.render(resource, options)
  end
  
  def success_response(status = 200, data = {})
    response = default_response(status, data)
    render json: response
  end
  
  def error_response(status, message)
    response = default_response(status, message)
    render json: response
  end
  
  def default_response(status, data, message = nil)
    { status: status, message: message }.merge(data)
  end
end
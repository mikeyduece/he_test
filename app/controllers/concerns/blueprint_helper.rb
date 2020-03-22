module BlueprintHelper
  
  def serialized_response(resource, blueprint, options = {})
    JSON.parse(blueprint.render(resource, options), symbolize_names: true)
  end
  
  def success_response(status = 200, data = {})
    response = default_response(status, data)
    render json: response
  end
  
  def error_response(status, message)
    response = default_response(status, {}, message)
    render json: response
  end
  
  def default_response(status, data, message = nil)
    { status: status, message: message }.merge(data)
  end
end
class ApplicationController < ActionController::Base
  before_action :log_headers
  after_action :log_response_content

  def log_headers
    headers = {}
    request.env.each do |key, value|
      headers[key.remove(/^HTTP_/).gsub('_', '-').downcase] = value if(key =~ /^HTTP_/)
    end
    logger.info "  Request Headers: #{ headers.to_s }"
  end

  def log_response_content
    logger.info "  Response Headers: #{ response.headers.to_s }"
    logger.info "  Response Body: #{ response.body }"
  end

  def formatted_params
    fparams = convert_string_to_types(request.parameters).with_indifferent_access
    fparams.extract!(:controller, :action, :format)
    fparams
  end

  def convert_string_to_types(value)
    case
    when value.is_a?(Hash) then
      value.each_with_object({}) do |(key, value), hash|
        hash[key] = convert_string_to_types(value)
      end
    when value.is_a?(String) then
      case
      when (value =~ /\A[-+]?[0-9]*\.[0-9]+\Z/) then value.to_f
      when (value =~ /\A[-+]?[0-9]*\Z/)         then value.to_i
      when value == "true"                      then true
      when value == "false"                     then false
      when value == "null"                      then nil
      else value
      end
    end
  end
end

class ApiController < ApplicationController

  def test
    params = formatted_params

    if params.has_key?(:status_code)
      head params.fetch(:status_code)
    end

    if params.has_key?(:redirect) && params[:redirect].to_i > 0
      params[:redirect] -= 1
      redirect_to url_for(params.merge(only_path: true)) and return
    end

    if params.has_key?(:sleep)
      sleep(params[:sleep].to_f)
    end

    if params.has_key?(:fresh)
      expires_now
    end

    if params.has_key?(:cookies)
      params[:cookies].each do |name, cookie_params|
        cookie_params[:expires] = cookie_params[:expires].seconds.from_now if cookie_params.has_key?(:expires)
        cookies[name] = cookie_params.to_h
      end
    end

    respond_to do |format|
      format.html    { render body: ("<html><body><pre>#{JSON.pretty_generate(params)}</pre></body></html>") }
      format.json    { render json: params }
      format.msgpack { render body: params.to_msgpack }
    end
  end


  def random
    chars = [*('A'..'Z'), *('a'..'z'), *('0'..'9')]
    length = (params[:length] || 1000).to_i
    string = length.times.map { chars.sample(length) }.join

    respond_to do |format|
      format.html    { render body: string }
      format.json    { render json: string }
      format.msgpack { render body: string.to_msgpack }
    end
  end

end

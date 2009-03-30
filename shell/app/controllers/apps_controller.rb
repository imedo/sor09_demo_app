require 'uri'
require 'net/http'

class AppsController < ApplicationController
  def dispatch
    host = host_for(params[:app])
    url = build_url(host)
    dispatch_request_for(url)
    handle_response
  rescue Timeout::Error
    @body = "Timeout: Application '#{params[:app]}' is not available at the moment."
  rescue Errno::ECONNREFUSED
    @body = "Connection refused: Application '#{params[:app]}' is not available at the moment."
  end
  
  private
  def dispatch_request_for(url)
    Timeout::timeout(2) do    
      Net::HTTP.start(url.host, url.port) do |http|
        header = {}
        header['X-Requested-With'] = 'XMLHttpRequest' if request.xhr?
        header['Referer'] = request.env['HTTP_REFERER'] || ""

        full_path = [url.path, url.query].compact.join('?')
        if request.get?
          @response, @body = http.get(full_path, header)
        else
          header['Content-Type'] = request.env['CONTENT_TYPE']
          @response, @body = http.post(full_path, request.raw_post, header)
        end
      end
    end
  end
  
  def host_for(application)
    case application
    when 'blog' then 'http://localhost:4000'
    when 'comments' then 'http://localhost:5000'
    end
  end
  
  def handle_response
    case @response.code.to_i
    when 500
      @body = "Error in Application '#{params[:app]}'"
    when 404
      @body = "Record not found in Application '#{params[:app]}'"
    when 301, 302
      redirect_to URI.parse(@response['location']).path, :status => @response.code.to_i
    end
  end
  
  def build_url(host)
    URI.parse([host, params[:app_controller], *params[:params]].join('/'))
  end
end

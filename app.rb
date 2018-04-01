require_relative 'time'

class App

  def call(env)  
    
    @request = Rack::Request.new(env)
    @user_format = (Rack::Utils.parse_nested_query(@request.query_string)).values.join.split(",")
    
    case @request.path 
    when  "/time"
      handle_one_request
    else
      not_found
    end     
    
    [@status, headers, @body]
  end

  private 

  def handle_one_request    
    @body = Time.new(@user_format)
    @status = 200
  end


  def not_found
    @status = 404
    @body = ["Not found"]
  end  

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  
end
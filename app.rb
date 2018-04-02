require_relative 'time_formatter'

class App

  def call(env)  
    
    @request = Rack::Request.new(env)
    @user_format = Rack::Utils.parse_nested_query(@request.query_string).values.join.split(",")
    request
    [@status, headers, @body]
  end

  private 

  def request

    case @request.path 
    when  "/time"
      handle_one_request
    else
      not_found
    end     

  end

  def handle_one_request    
    time_formatter = TimeFormatter.new(@user_format)
    
    
    if time_formatter.acceptably?
      @status = 200
      @body = ["#{time_formatter.return_time}"]
    else
      @status = 400
      @body = ["Unknown time format #{time_formatter.return_time}"]
    end    
  end


  def not_found
    @status = 404
    @body = ["Not found"]
  end  

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  
end
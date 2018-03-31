class App

  def call(env)  
    @query = env["QUERY_STRING"] 
    @path = env["REQUEST_PATH"]
    @user_format = (Rack::Utils.parse_nested_query(@query)).values.join.split(",")
    @acceptable_format = %w(year month day hour minute second)
    [status, headers, body]
  end

  private 

  def status
    if true_path? && acceptably?
      200
    elsif true_path?
      400
    else
      404
    end      
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body

    if true_path? && acceptably?
      
      [convert_user_format]      

    elsif true_path?
      
      ["Unknown time format #{unknown_time_format}"]
      
    else
      ['Not found']    
    end
    
  end

  def true_path?
    @path == "/time"
  end


  def acceptably?
    (@user_format - @acceptable_format).empty?
  end 

  def unknown_time_format
    @user_format - @acceptable_format
  end

  def convert_user_format
    @user_format.map! { |t| case t
                                when "year"
                                  t = Time.now.year
                                when "month"
                                  t = Time.now.month
                                when "day"
                                  t = Time.now.day
                                when "hour"
                                  t = Time.now.hour
                                when "minute"
                                  t = Time.now.min
                                when "second"
                                  t = Time.now.sec        
                              end     
                            }
    @user_format.join("-")                           
  end

end


class TimeFormatter

  def initialize(array)
    
    @format = ["year", "month", "hour"]
    @acceptable_format = %w(year month day hour minute second)
    return_time

  end

  def acceptably?
    (@format - @acceptable_format).empty?
  end 

  def unknown_time_format
    @format - @acceptable_format
  end

  def convert_user_format
    @format.map! { |t| case t
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
    @format.join("-")                           
  end

  def return_time

    if acceptably?
      convert_user_format
    else
      unknown_time_format
    end
    
  end    

end
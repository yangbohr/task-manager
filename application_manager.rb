class ApplicationManager 
require 'date'
attr_accessor :start_date, :count ,:next_start_date
DAYS_IN_MONTH = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  def initialize(start_date, count)
    @start_date = Date.parse start_date
    raise 'count should be in between 1 and 12' if count > 12 or count < 0
    @count= count
    @next_start_date = @start_date
  end

  def task_dates
    date_array = []
    count.times do 
      date_array << next_date
    end
    date_array
  end
  
  def next_date
   date = @next_start_date 
   if date.month == 12
     month = 01 
     day = start_date.day
     year = date.year + 1
   else
     month = date.month + 1
     year = date.year
     if month == 2 && start_date.day > 28
       day = feb_days(date)
     elsif start_date.day == 31 
       day = DAYS_IN_MONTH[month - 1]
     else
       day = start_date.day
     end
   end
   @next_start_date = Date.parse(year.to_s + '-' + month.to_s + '-' + day.to_s)
   @next_start_date.to_s
  end

  def feb_days(date)
    date.leap? ? 29 : 28
  end
end

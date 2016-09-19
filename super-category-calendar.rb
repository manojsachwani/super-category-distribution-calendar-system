require 'sinatra'
require 'date'

topics = [ 'Category-1', 'Category-2', 'Category-3', 'Category-4', 'Category-5', 'Category-6', 'Category-7']


odd_topics = ['Odd-Category-1', 'Odd-Category-2']

start_date = Date.today


end_date = Date.new(start_date.year,12,31) + 1

cal_topics = Hash.new
no_of_rotates = 0
while start_date < end_date

  temp_topics = topics
  if start_date.monday? or start_date.tuesday? or start_date.wednesday?
    if no_of_rotates > 0  and no_of_rotates < 7
      temp_topics = topics
      temp_topics.rotate(no_of_rotates)
    end
    cal_topics[start_date.to_s] = temp_topics[no_of_rotates]
    no_of_rotates += 1
    if no_of_rotates > 6
      no_of_rotates = 0
    end

  end

  if start_date.thursday?
    if start_date.day.even?
      cal_topics[start_date.to_s] = odd_topics[0]
    else
      cal_topics[start_date.to_s] = odd_topics[1]
    end
  end

  if start_date.friday?
    cal_topics[start_date.to_s] = "Fixed category for every friday"
  elsif start_date.saturday?
    cal_topics[start_date.to_s] = "Fixed category for every saturday"
  elsif start_date.sunday?
    cal_topics[start_date.to_s] = "Fixed category for every sunday"
  end
  start_date = start_date + 1
end

get '/' do

  erb :index, :locals => { :cal_topics => cal_topics, :start_date => Date.today, :end_date=> end_date }

end

not_found do
  'This is nowhere to be found.'
end

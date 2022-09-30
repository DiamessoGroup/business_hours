desc "Return Business Time Between Two Times"
task :tb do
  puts "Rake task will run"

  def distance_between(t1, t2)
    time_difference = 0
    time_difference_in_hours = 0

    while t1 < t2

      if t1.on_weekend?
        t1 = t1.next_weekday
        t1 = t1.change(hour: 9, min: 00)
      end

      if t2.on_weekend?
        t2 = t2.next_weekday
        t2 = t2.change(hour: 9, min: 00)
      end

      t1 = t1.change(hour: 9, min: 00, sec: 00) if t1 < t1.change(hour: 9, min: 00, sec: 00)
      t2 = t2.change(hour: 17, min: 00, sec: 00) if t2 > t2.change(hour: 17, min: 00, sec: 00)

      if t1.on_weekday? && t2.on_weekday? #times are on weekdays
        if t1.day == t2.day
          #times are on the same days
          time_difference += t2 - t1 if t1 < t2
        else
          #times are not on the same days
          time_difference += t1.change(hour: 17, min: 00, sec: 00) - t1 if t1 < t1.change(hour: 17, min: 00, sec: 00)
        end
      end
      t1 = t1.advance(days: 1)
      t1 = t1.change(hour: 9, min: 00)
    end

    time_difference_in_hours = (time_difference / 3600).round(2)
    puts "#{time_difference} seconds"
    puts "#{time_difference_in_hours} hours"
  end

  a = Time.parse("Friday, September 09 2022 at 10:20 EDT")
  b = Time.parse("Thursday, September 15 2022 at 03:35 EDT")

  distance_between(a, b)
  puts "Rake task has run"
end

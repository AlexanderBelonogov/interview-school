module ApplicationHelper
  def duration_to_minutes(time)
    time / 60
  end

  def start_end_time_for_select
    arr = []
    start = Section::TIME[:start_time]
    end_at = Section::TIME[:end_time] - Section::DURATION[50]
    while start <= end_at do
      arr << [start.to_am_pm, start]
      start += 600
    end
    arr
  end
end

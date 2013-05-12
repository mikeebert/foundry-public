require 'date'

class Weeks

  def self.apprenticeship_weeks(start_date, end_date)
    n = 1
    weeks = {n => start_date}

    if start_date.sunday?
      next_monday = start_date + 1
    else
      next_monday = start_date + (8 - start_date.wday)
    end

    while next_monday <= end_date
      weeks[n += 1] = next_monday
      next_monday += 7
    end

    weeks
  end

  def self.this_week_includes(date)
    (self.most_recent_monday .. self.most_recent_monday + 6).to_a.include?(date)
  end

  def self.most_recent_monday
    today = Date.today
    if today.sunday?
      return today - 6
    else
      delta = today.wday - 1
      return Date.today - delta
    end
  end
end

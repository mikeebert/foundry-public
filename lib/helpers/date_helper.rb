require 'date'

class DateHelper

  def self.format(date)
    Date.strptime(date, "%m/%d/%Y")
  end

end

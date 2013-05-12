require 'data_mapper'
require 'weeks'
require 'date'

class Apprenticeship
  include DataMapper::Resource

  property :id,           Serial
  property :start_date,   Date, :required => true
  property :end_date,     Date, :required => true

  property :created_at,   DateTime
  property :updated_at,   DateTime

  belongs_to :apprentice, 'User', :child_key => [:apprentice_id]
  belongs_to :mentor, 'User', :child_key => [:mentor_id]

  has n, :tasks, :constraint => :destroy
  has n, :feedback, :constraint => :destroy
  has n, :blogposts, :constraint => :destroy

  def include?(user)
    user == self.apprentice || user == self.mentor
  end

  def weeks
    Weeks.apprenticeship_weeks(self.start_date, self.end_date)
  end

  def current_week
    current_week = weeks.select {|week_number,week_date| Weeks.this_week_includes(week_date)}
    current_week == {} ? final_week : current_week
  end

  def final_week
    {weeks.to_a.last[0] => weeks.to_a.last[1]}
  end

  def current_week_number
    current_week.keys[0]
  end
  
  def current_week_date
    current_week.values[0]
  end

  def current_and_future_weeks
    weeks.select {|week_number, date| date >= current_week_date}
  end

  def past_weeks
    weeks.select {|week_number, date| date < current_week_date}
  end

  def weeks_starting_in_last_ten_days
    current_weeks = weeks.select do
      |week_number, date| date <= Date.today && date >= Date.today - 10
    end
    current_weeks.keys    
  end

  def tasks_for_week(n)
    self.tasks(:week => n)
  end

  def all_weekly_tasks
    self.tasks.select {|task| task.week != 0}
  end

  def all_general_tasks
    self.tasks.select {|task| task.week == 0}
  end
  
  def feedback_for_week(n)
    self.feedback.select {|feedback| feedback.week == n}
  end

  def posts_for_week(n)
    self.blogposts.select {|post| post.week == n}
  end
end



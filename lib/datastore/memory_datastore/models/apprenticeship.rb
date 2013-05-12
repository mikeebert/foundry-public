require 'repository'
require 'helpers/date_helper'
require 'weeks'
require 'date'

module Memory
  class Apprenticeship
    attr_accessor :id, :apprentice_id, :mentor_id, :start_date, :end_date

    def initialize(params = {})
      @mentor_id = params[:mentor_id].to_i
      @apprentice_id = params[:apprentice_id].to_i
      @start_date = params[:start_date]
      @end_date = params[:end_date]
    end

    def apprentice
      Repository.for(:user).find_by_id(self.apprentice_id)
    end

    def mentor
      Repository.for(:user).find_by_id(self.mentor_id)
    end

    def include?(user)
      user == apprentice || user == mentor
    end

    def weeks
      Weeks.apprenticeship_weeks(@start_date, @end_date)
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

    def tasks_for_week(week)
      Repository.for(:task).apprenticeship_week(@id,week)
    end

    def all_weekly_tasks
      Repository.for(:task).all_weekly_tasks_for(@id)
    end

    def all_general_tasks
      Repository.for(:task).general_tasks_for_apprentice(@id)
    end

    def feedback_for_week(n)
      Repository.for(:feedback).feedback_for_apprenticeship_and_week(@id, n)
    end

    def weeks_starting_in_last_ten_days
      current_weeks = weeks.select do
        |week_number, date| date <= Date.today && date >= Date.today - 10
      end
      current_weeks.keys    
    end

    def posts_for_week(n)
      Repository.for(:blogpost).posts_for_apprenticeship_and_week(@id, n)
    end

  end
end

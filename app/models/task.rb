class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user

  def formatted_task
    # Format start_time and end_time
    start_time_str = start_time.strftime("%I:%M %p") # Format: 10:00 AM
    end_time_str = end_time.strftime("%I:%M %p") # Format: 11:00 AM
    date_str = start_time.strftime("%b %d") # Format: Jan 01

    # Return the formatted task string
    "#{name}, #{duration} (#{start_time_str} - #{end_time_str}, #{date_str})"
  end

  def duration_in_minutes
    ((end_time - start_time) / 60).to_i
  end

  def self.total_time
    total_duration_in_minutes = self.sum { |task| task.duration_in_minutes }
    hours = total_duration_in_minutes / 60
    minutes = total_duration_in_minutes % 60
    "#{hours} hours and #{minutes} minutes"
  end

end

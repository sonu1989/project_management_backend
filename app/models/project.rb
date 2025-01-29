class Project < ApplicationRecord
  has_many :tasks
  has_and_belongs_to_many :users

  # Scope to find active projects
  # scope :active, -> {
  #   today = Date.today
  #   where("start_date <= ? AND (start_date + INTERVAL duration) >= ?", today, today)
  # }

  scope :active, -> {
  where("start_date <= ? AND start_date + 
         CASE 
           WHEN duration ~ 'day' THEN (CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) * INTERVAL '1 day')
           WHEN duration ~ 'week' THEN (CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) * INTERVAL '7 days')
           WHEN duration ~ 'month' THEN (CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) * INTERVAL '30 days')
           ELSE INTERVAL '0 day'
         END >= ?", Date.today, Date.today)
}


end

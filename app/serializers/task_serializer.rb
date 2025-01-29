class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_time, :end_time, :duration
  
  attribute :start_time do
    object.start_time.strftime("%d/%m/%Y %I:%M %p")
  end

  attribute :end_time do
    object.start_time.strftime("%d/%m/%Y %I:%M %p")
  end

  attribute :detail_break_down do
    object.formatted_task
  end

end

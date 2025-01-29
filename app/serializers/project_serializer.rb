class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :duration

  # If a project has tasks, you can include them too
  has_many :tasks
end

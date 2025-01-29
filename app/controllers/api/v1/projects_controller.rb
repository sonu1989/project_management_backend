class Api::V1::ProjectsController < ApplicationController
  include Authenticable
  before_action :authenticate_request

  before_action :set_project, only: [:tasks_breakdown, :assign_user, :remove_user]

  def index
    if current_user.admin?
      @projects = Project.active.includes(:users)
    else
      @projects = current_user.projects.active.includes(:users)
    end
    render json: @projects.to_json(include: :users)
  end

  def show
    @project = Project.find(params[:id])
    render json: @project
  end

  def tasks
    @project = Project.find(params[:id])
    @tasks = @project.tasks.order('start_time ASC')  # Assuming there is a has_many :tasks association in Project
    render json: { tasks: ActiveModel::Serializer::CollectionSerializer.new(@tasks, serializer: TaskSerializer), total_duration: @tasks.total_time }
  end

  def tasks_breakdown
    tasks = @project.tasks
    breakdown = tasks.map do |task|
      {name: task.name,duration: task.duration, time_range: "#{task.start_time.strftime('%I:%M %p')} - #{task.end_time.strftime('%I:%M %p')} on #{task.start_time.to_date}" }
    end
    total_duration = tasks.sum(&:duration)
    render json: { breakdown: breakdown, total_duration: "#{total_duration} hours" }
  end

  def assign_user
    user = User.find_by(id: params[:user_id])
    if user
      @project.users << user
    end
    render json: Project.active.includes(:users).to_json(include: :users)
  end

  def remove_user
    user = User.find_by(id: params[:user_id])
    if user
      @project.users.delete(user)
    end
    render json: Project.active.includes(:users).to_json(include: :users)
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end
end

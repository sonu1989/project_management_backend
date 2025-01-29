module Api
  module V1
    class TasksController < ApplicationController
      include Authenticable
      before_action :authenticate_request
      
      before_action :set_task, only: [:show, :update, :destroy]

      # GET /api/v1/tasks
      def index
        tasks = current_user.tasks
        render json: tasks, status: :ok
      end

      # GET /api/v1/tasks/:id
      def show
        render json: @task, status: :ok
      end

      # POST /api/v1/tasks
      def create
        project =  current_user.projects.active.find_by(id: params[:task][:project_id])
        return render json: { errors: 'Project not found. Please select project' } unless project
        task = current_user.tasks.build(task_params)
        if task.save
          render json: task, status: :created
        else
          render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/tasks/:id
      def update
        if @task.update(task_params)
          render json: @task, status: :ok
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/tasks/:id
      def destroy
        @task.destroy
        render json: { message: 'Task deleted successfully' }, status: :ok
      end

      private

      def set_task
        @task = current_user.tasks.find_by(id: params[:id])
        render json: { error: 'Task not found' }, status: :not_found unless @task
      end

      def task_params
        params.require(:task).permit(:name, :description, :start_time, :end_time, :duration, :project_id)
      end
    end
  end
end

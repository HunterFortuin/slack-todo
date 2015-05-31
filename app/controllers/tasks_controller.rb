class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id

    if @task.save
        redirect_to :back, notice: "Task created"
    else
        redirect_to :back, @task.errors.full_messages.to_sentence
    end
  end

  def update
    if @task.update_attributes(task_params)
        redirect_to :back, notice: "Task updated"
    else
        redirect_to :back, @task.errors.full_messages.to_sentence
    end
  end

  def destroy
    @task.destroy
    redirect_to :back, notice: "Task destroyed"
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :complete)
  end
end

class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_task_owner, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.current_user_tasks(current_user).in_reverse_created_date_order.page(params[:page])

    if params[:sort_deadline_on].present?
      @tasks = Task.in_deadline_date_order.page(params[:page])
    end
    if params[:sort_priority].present?
      @tasks = Task.sorted_by_priority.in_reverse_created_date_order.page(params[:page])
    end

    if params[:search].present?
      if params[:search][:title].present? && params[:search][:status].present?
        @tasks = Task.title_status_search(params[:search][:title], params[:search][:status]).in_reverse_created_date_order.page(params[:page])
      elsif params[:search][:title].present?
        @tasks = Task.title_search(params[:search][:title]).in_reverse_created_date_order.page(params[:page])
      elsif params[:search][:status].present?
        @tasks = Task.status_search(params[:search][:status]).in_reverse_created_date_order.page(params[:page])
      elsif params[:search][:label].present?
        @label = Label.find(params[:search][:label])
        @tasks = @label.tasks.in_reverse_created_date_order.page(params[:page])
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('.created')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if params[:label_ids].nil?
      @task.labels.clear
    end
    if @task.update(task_params)
      redirect_to task_path(@task.id), notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('.destroyed')
  end

  private

  def set_task
    @task = Task.with_labels.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline_on, :priority, :status, { label_ids: [] })
  end

  def correct_task_owner
    set_task
    redirect_to tasks_path, notice: t('notice.reject') unless current_user.id == @task.user_id
  end
end

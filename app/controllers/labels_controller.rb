class LabelsController < ApplicationController
  before_action :set_label, only: [:edit, :update, :destroy]
  before_action :correct_label_owner, only: [:edit]

  def index
    @labels = current_user.labels.with_num_of_tasks
  end

  def new
    @label = Label.new
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      redirect_to labels_path, notice: t('.created')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path, notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path, notice: t('.destroyed')
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name)
  end

  def correct_label_owner
    set_label
    redirect_to labels_path, notice: t('notice.reject') unless current_user.id == @label.user_id
  end
end

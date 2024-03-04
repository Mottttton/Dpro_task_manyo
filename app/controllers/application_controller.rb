class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :sign_in_required

  private

  def sign_in_required
    redirect_to new_session_path, notice: t('notice.require_sign_in') unless current_user
  end

  def sign_out_required
    redirect_to tasks_path, notice: t('notice.require_sign_out') if logged_in?
  end
end

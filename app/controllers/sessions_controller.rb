class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(employee_number: params[:session][:employee_number])
    if user &.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      log_in user
      redirect_to forwarding_url || new_post_path
    else
      flash.now[:alert] = '社員番号またはパスワードが無効です。'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end

  def redirect_if_logged_in
    if logged_in?
      redirect_to new_post_path
    end
  end
end

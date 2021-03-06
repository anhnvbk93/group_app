# Session Controller: Control log in, log out, session features...
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      login_successfully_processing(user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def account_activated_processing(user)
    log_in user
    params[:session][:remember_m] == '1' ? remember(user) : forget(user)
    redirect_back_or user
  end

  def account_not_activated_processing
    message  = 'Account not activated. '
    message += 'Check your email for the activation link.'
    flash[:warning] = message
    redirect_to root_url
  end

  def login_successfully_processing(user)
    if user.activated?
      account_activated_processing(user)
    else
      account_not_activated_processing
    end
  end
end

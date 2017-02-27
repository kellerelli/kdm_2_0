class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(:username => params[:session][:username].downcase).all.first
    pp "found"
    pp user
    if user && user.authenticate(params[:session][:password])
      pp "loged in"
      log_in user
      redirect_to user
    else
      pp "failed"
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end

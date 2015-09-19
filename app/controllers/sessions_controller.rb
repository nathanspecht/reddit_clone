class SessionsController < ApplicationController

  def new
    unless current_user
      render :new
    else
      redirect_to user_url(current_user)
    end
  end

  def create
    username = params[:user][:username]
    password = params[:user][:password]

    @user = User.find_by_credentials(username, password)

    if @user
      login(@user)
      flash[:message] = ["welcome back #{@user.username}"]
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["invalid credentials"]
      render :new
    end
  end


  def destroy
    logout(current_user)
    redirect_to users_url
  end

end

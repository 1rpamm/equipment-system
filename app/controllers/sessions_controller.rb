# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:login], params[:password], params[:remember_me])
    if user
      user.login_count +=1
      user.last_login_at = Time.now
      user.save
      redirect_back_or_to root_url, :notice => "Вы авторизовались как #{user.name}!"
    else
      flash[:error]="Неверное имя пользователя или пароль"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, :notice => "Выход выполнен!"
  end
end

# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  def check_auth
    unless logged_in?
      flash[:error]="Доступ запрещен"
      redirect_to new_session_path
    end
  end

  def admin_permission
    unless current_user.admin_user?
      flash[:error]="Доступ запрещен"
    end
  end

  def admin_equip
    unless current_user.admin_equip?
      flash[:error]="Доступ запрещен"
    end
  end

  def admin_inv
    unless current_user.admin_inv?
      flash[:error]="Доступ запрещен"
    end
  end

  def responsible
    unless current_user.responsible?
      flash[:error]="Доступ запрещен"
    end
  end
end

# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :check_auth, :admin_permission, :except => ['show', 'index']

  # GET /users
  # GET /users.json
  def index


    respond_to do |format|
      format.html {
        @users = User.order("deleted_at DESC, admin_user+admin_equip+admin_inv+responsible DESC, login", :login).page(params[:page])
      }
      format.json {
        @users=User.where("name like ? or email like ?","#{params[:q]}%","#{params[:q]}%").all
        render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Пользователь успешно создан.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, notice: 'Данные пользователя успешно обновлены.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    #@user.destroy
    if @user.deleted_at.nil?
      @user.deleted_at = Time.now
      flag = 1
    else
      @user.deleted_at = nil
      flag = 0
    end
    @user.save
    respond_to do |format|
      if flag == 1
        format.html { redirect_to users_url, notice: "Пользователь #{@user.name} успешно удален" }
        format.json { head :no_content }
      else
        format.html { redirect_to users_url, notice: "Пользователь #{@user.name} успешно восстановлен!" }
        format.json { head :no_content }
      end
    end
  end
end

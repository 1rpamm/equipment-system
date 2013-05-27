# -*- encoding : utf-8 -*-
class EquipmentController < ApplicationController
  before_filter :check_auth
  # GET /equipment
  # GET /equipment.json
  def index
    @equipment = Equipment.full_load.order("deleted_at, accepted_at, domain_name").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @equipment }
    end
  end

  # GET /equipment/1
  # GET /equipment/1.json
  def show
    @equipment = Equipment.full_load.find(params[:id])
    @comments = @equipment.comments.includes(:user).page(params[:page]).per(10)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @equipment }
    end
  end

  # GET /equipment/new
  # GET /equipment/new.json
  def new
    @equipment = Equipment.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @equipment }
    end
  end

  # GET /equipment/1/edit
  def edit
    @equipment = Equipment.find(params[:id])
  end

  # comment /equipment
  # comment /equipment.json
  def create
    @equipment = Equipment.new(params[:equipment])

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to @equipment, notice: 'Оборудование успешно создано.' }
        format.json { render json: @equipment, status: :created, location: @equipment }
      else
        format.html { render action: "new" }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /claims/1/history
  def show_history
    @events = {
        "create" => "создал",
        "update" => "отредактировал",
        "accept" => "принял",
        "delete" => "удалил"
    }
    users=[]
    @versions = Version.where(:item_type=>"Equipment",:item_id=>params[:id]).page(params[:page]).per(10)
    @versions.each do |v|
      users << v.whodunnit # if v.whodunnit
      v.object = YAML::load(v.object) if v.object
    end
    @users = User.all
    @equipment = params[:id]
    #@users=User.where(:id=>users).order(:id).select("id, login, role")
    render "history"
  end

  # PUT /equipment/1
  # PUT /equipment/1.json
  def update
    @equipment = Equipment.find(params[:id])

    respond_to do |format|
      if @equipment.update_attributes(params[:equipment])
        format.html { redirect_to @equipment, notice: 'Данные оборудования успешно обновлены.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # ACCEPT /equipment/1
  # ACCEPT /equipment/1.json
  def accept
    @equipment = Equipment.find(params[:id])
    #@equipment.destroy
    @equipment.accepted_at = Time.now
    @equipment.save
    respond_to do |format|
      format.html { redirect_to equipment_index_url, notice: 'Оборудование успешно принято.' }
      format.json { head :no_content }
    end
  end

  # DELETE /equipment/1
  # DELETE /equipment/1.json
  def destroy
    @equipment = Equipment.find(params[:id])
    #@equipment.destroy
    if @equipment.deleted_at.nil?
      @equipment.deleted_at = Time.now
      flag = 1
    else
      @equipment.deleted_at = nil
      flag = 0
    end
    @equipment.save
    respond_to do |format|
      if flag == 1
        format.html { redirect_to equipment_index_url, notice: 'Оборудование успешно удалено.' }
        format.json { head :no_content }
      else
        format.html { redirect_to equipment_index_url, notice: 'Оборудование успешно восстановлено.' }
        format.json { head :no_content }
      end
    end
  end
end

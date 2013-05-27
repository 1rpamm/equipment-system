# -*- encoding : utf-8 -*-
class SubsystemsController < ApplicationController
  before_filter :check_auth
  # GET /subsystems
  # GET /subsystems.json
  def index
    @subsystems = Subsystem.full_load.order(:name).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subsystems }
    end
  end

  # GET /subsystems/1
  # GET /subsystems/1.json
  def show
    @subsystem = Subsystem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subsystem }
    end
  end

  # GET /subsystems/new
  # GET /subsystems/new.json
  def new
    @subsystem = Subsystem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subsystem }
    end
  end

  # GET /subsystems/1/edit
  def edit
    @subsystem = Subsystem.find(params[:id])
  end

  # POST /subsystems
  # POST /subsystems.json
  def create
    @subsystem = Subsystem.new(params[:subsystem])

    respond_to do |format|
      if @subsystem.save
        format.html { redirect_to @subsystem, notice: 'Подсистема успешно создана.' }
        format.json { render json: @subsystem, status: :created, location: @subsystem }
      else
        format.html { render action: "new" }
        format.json { render json: @subsystem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subsystems/1
  # PUT /subsystems/1.json
  def update
    @subsystem = Subsystem.find(params[:id])

    respond_to do |format|
      if @subsystem.update_attributes(params[:subsystem])
        format.html { redirect_to @subsystem, notice: 'Данные подсистемы успешно обновлены.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subsystem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subsystems/1
  # DELETE /subsystems/1.json
  def destroy
    @subsystem = Subsystem.find(params[:id])
    @subsystem.destroy

    respond_to do |format|
      format.html { redirect_to subsystems_url }
      format.json { head :no_content }
    end
  end
end

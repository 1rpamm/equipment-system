# -*- encoding : utf-8 -*-
class EquipmentController < ApplicationController
  before_filter :check_auth
  # GET /equipment
  # GET /equipment.json
  def index
    @equipment = Equipment.full_load.page(params[:page])
    Dir.chdir("public") do
      @mpdfs = Dir.glob("reports/user#{current_user.id}/*.pdf")
    end
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
    Dir.chdir("public") do
      @pdfs = Dir.glob("reports/#{params[:id]}/*.pdf")
    end
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
      @equipment.accepted_at = nil
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

  def pdf
    equipment = Equipment.find(params[:id])
    date = l Time.now, format: :long
    headers = ['Производитель', 'Устройство', 'rev.']
    widths = [140, 365, 35]
    if equipment.deleted_at
      deleted_at = l equipment.deleted_at, format: :long
    elsif equipment.accepted_at
      accepted_at = l equipment.accepted_at, format: :long
    end
    updated_at = l equipment.updated_at, format: :long
    require "prawn"
    Dir.chdir("public/reports") do
      if Dir[params[:id]] == []
        Dir.mkdir(params[:id])
      end
      Dir.chdir(params[:id]) do
        Prawn::Document.generate(equipment.domain_name+".pdf") do
          font = "Verdana"
          font_families.update(
              font => {
                  :bold => "#{Rails.root}/app/assets/fonts/verdanab.ttf",
                  :italic => "#{Rails.root}/app/assets/fonts/verdanai.ttf",
                  :normal  => "#{Rails.root}/app/assets/fonts/verdana.ttf" })
          font font, :size => 10
          text "<b>МОСКОВСКИЙ ГОСУДАРСТВЕННЫЙ ИНДУСТРИАЛЬНЫЙ УНИВЕРСИТЕТ</b>", :size => 13, :align => :center, :inline_format => true
          text "Система учета компьютерного и сетевого оборудования", :size => 12, :align => :center
          move_down 20
          text "<b>Оборудование:</b> #{equipment.domain_name}", :inline_format => true
          text "<b>Материально-ответственный:</b> #{equipment.responsible.name}", :inline_format => true
          text "<b>Инвентарный номер:</b> #{equipment.inventory.inv_num}", :inline_format => true
          text "<b>Кабинет:</b> #{equipment.room.name}", :inline_format => true
          if equipment.deleted_at

            text "<b>Удалено:</b> #{deleted_at}", :inline_format => true
          elsif equipment.accepted_at
            text "<b>Принято:</b> #{accepted_at}", :inline_format => true
          end
          text "<b>Последнее обновление:</b> #{updated_at}", :inline_format => true
          text "<b>Список деталей в оборудовании:</b>", :inline_format => true
          data = []
          data += [headers]
          equipment.details.each do |detail|
            data += [[detail.vendor.name, detail.device.name, detail.rev]]
          end
          table(data, :row_colors => %w[eeeeee ffffff], :column_widths => widths)
          date = "Отчет сформирован: #{date}"
          go_to_page(page_count)
          move_down(710)
          text date, :align => :right, :style => :italic, :size => 9
        end
      end
    end
    #render
    redirect_to equipment, notice: 'Отчет сформирован'
  end

  def mpdf
    user = User.find(params[:id])
    equipments = Equipment.includes(:details).where(:responsible_id => user.id).order("deleted_at DESC", :domain_name)
    date = l Time.now, format: :long
    headers = ['Производитель', 'Устройство', 'rev.']
    widths = [140, 365, 35]
    deleted_at = []
    accepted_at = []
    updated_at = []
    equipments.each_with_index do |equipment, i|
      if equipment.deleted_at
        deleted_at[i] = l equipment.deleted_at, format: :long
        accepted_at[i] = 0
      elsif equipment.accepted_at
        accepted_at[i] = l equipment.accepted_at, format: :long
        deleted_at[i] = 0
      end
      updated_at[i] = l equipment.updated_at, format: :long
    end
    require "prawn"
    Dir.chdir("public/reports") do
      if Dir["user#{params[:id]}"] == []
        Dir.mkdir("user#{params[:id]}")
      end
      Dir.chdir("user#{params[:id]}") do
        Prawn::Document.generate(user.login+".pdf") do
          font = "Verdana"
          font_families.update(
              font => {
                  :bold => "#{Rails.root}/app/assets/fonts/verdanab.ttf",
                  :italic => "#{Rails.root}/app/assets/fonts/verdanai.ttf",
                  :normal  => "#{Rails.root}/app/assets/fonts/verdana.ttf" })
          font font, :size => 10
          text "<b>МОСКОВСКИЙ ГОСУДАРСТВЕННЫЙ ИНДУСТРИАЛЬНЫЙ УНИВЕРСИТЕТ</b>", :size => 13, :align => :center, :inline_format => true
          text "Система учета компьютерного и сетевого оборудования", :size => 12, :align => :center
          text "Cписок оборудования пользователя #{user.name}", :size => 12, :align => :center
          move_down 20
          equipments.each_with_index do |equipment, i|
            text "<b>Оборудование:</b> #{equipment.domain_name}", :inline_format => true
            text "<b>Инвентарный номер:</b> #{equipment.inventory.inv_num}", :inline_format => true
            text "<b>Кабинет:</b> #{equipment.room.name}", :inline_format => true
            if equipment.deleted_at
              text "<b>Удалено:</b> #{deleted_at[i]}", :inline_format => true
            elsif equipment.accepted_at
              text "<b>Принято:</b> #{accepted_at[i]}", :inline_format => true
            end
            text "<b>Последнее обновление:</b> #{updated_at[i]}", :inline_format => true
            text "<b>Список деталей в оборудовании:</b>", :inline_format => true
            data = []
            data += [headers]
            equipment.details.each do |detail|
              data += [[detail.vendor.name, detail.device.name, detail.rev]]
            end
            table(data, :row_colors => %w[eeeeee ffffff], :column_widths => widths)
            move_down 20
          end
          date = "Отчет сформирован: #{date}"
          go_to_page(page_count)
          move_down(710)
          text date, :align => :right, :style => :italic, :size => 9
        end
      end
    end
    #render
    redirect_to equipment_index_path, notice: 'Отчет сформирован'
  end
end

# -*- encoding : utf-8 -*-
class CommentsController < ApplicationController
  before_filter :check_auth
  before_filter :load_equipment

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  def new
    @comment = @equipment.comments.build
  end

  # GET /comments/1/edit
  def edit
    @comment = @equipment.comments.find(params[:id])
  end

  # POST /comments
  def create
    @comment = @equipment.comments.new(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @equipment, notice:'Сообщение создано'
    else
      render 'new'
    end
  end

  # PUT /comments/1
  def update
    @comment = @equipment.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to @equipment, :notice => "Сообщение обновлено"
    else
      render 'edit'
    end

  end

  # DELETE /comments/1
  def destroy
    @comment = @equipment.comments.find(params[:id])
    @comment.destroy
    redirect_to @equipment, :notice => "Сообщение удалено"
  end

  private
  def load_equipment
    @equipment=Equipment.find(params[:equipment_id])
  end
end

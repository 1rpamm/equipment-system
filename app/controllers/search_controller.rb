class SearchController < ApplicationController
  def search
    @acts = ActType.search {
      keywords "#{params[:query]}"
    }.results
    @details = Detail.search {
      keywords "%#{params[:query]}%"
    }.results
    @equipment = Equipment.search {
      keywords "#{params[:query]}%"
    }.results
    @inventories = Inventory.search {
      keywords "#{params[:query]}"
    }.results
    @rooms = Room.search {
      keywords "%#{params[:query]}%"
    }.results
    @users = User.search  {
      keywords "%#{params[:query]}%"
    }.results

    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @results }
    end
  end
end

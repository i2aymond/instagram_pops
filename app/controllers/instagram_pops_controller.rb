class InstagramPopsController < ApplicationController
  # GET /instagram_pops
  # GET /instagram_pops.json
  def index
    @instagram_pops = InstagramPop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @instagram_pops }
    end
  end

  def showcase
    # TODO: not much is needed for now
  end

  # GET /instagram_pops/1
  # GET /instagram_pops/1.json
  def show
    begin
      @instagram_pop = InstagramPop.find(params[:id].to_i)

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @instagram_pop }
      end
    rescue
      render :text => "404 Not Found", :status => 404
    end
  end

  # we are not making any new model
  def new
    # do nothing
  end

  # we are not editing any model
  def edit
    # do nothing
  end

  # we are not making any new model
  def create
    # do nothing
  end

  # we are not making any new model
  def update
    # do nothing
  end

  # we are not destroying any model
  def destroy
    # do nothing
  end
end

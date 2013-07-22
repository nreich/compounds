class SaltsController < ApplicationController
  # GET /salts
  # GET /salts.json
  def index
    @salts = Salt.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @salts }
    end
  end

  # GET /salts/1
  # GET /salts/1.json
  def show
    @salt = Salt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @salt }
    end
  end

  # GET /salts/new
  # GET /salts/new.json
  def new
    @salt = Salt.new
    authorize! :new, @salt

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @salt }
    end
  end

  # GET /salts/1/edit
  def edit
    @salt = Salt.find(params[:id])
    authorize! :edit, @salt
  end

  # POST /salts
  # POST /salts.json
  def create
    @salt = Salt.new(params[:salt])
    authorize! :create, @salt

    respond_to do |format|
      if @salt.save
        format.html { redirect_to @salt, notice: 'Salt was successfully created.' }
        format.json { render json: @salt, status: :created, location: @salt }
      else
        format.html { render action: "new" }
        format.json { render json: @salt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /salts/1
  # PUT /salts/1.json
  def update
    @salt = Salt.find(params[:id])
    authorize! :update, @salt

    respond_to do |format|
      if @salt.update_attributes(params[:salt])
        format.html { redirect_to @salt, notice: 'Salt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @salt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salts/1
  # DELETE /salts/1.json
  def destroy
    @salt = Salt.find(params[:id])
    authorize! :destroy, @salt
    @salt.destroy

    respond_to do |format|
      format.html { redirect_to salts_url }
      format.json { head :no_content }
    end
  end
end

class MoleculesController < ApplicationController
  # GET /molecules
  # GET /molecules.json
  def index
    @molecules = Molecule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @molecules }
    end
  end

  # GET /molecules/1
  # GET /molecules/1.json
  def show
    @molecule = Molecule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @molecule }
    end
  end

  # GET /molecules/new
  # GET /molecules/new.json
  def new
    @molecule = Molecule.new
    authorize! :new, @molecule

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @molecule }
    end
  end

  # GET /molecules/1/edit
  def edit
    @molecule = Molecule.find(params[:id])
    authorize! :edit, @molecule
  end

  # POST /molecules
  # POST /molecules.json
  def create
    @molecule = Molecule.new(params[:molecule])
    authorize! :create, @molecule

    respond_to do |format|
      if @molecule.save
        format.html { redirect_to @molecule, notice: 'Molecule was successfully created.' }
        format.json { render json: @molecule, status: :created, location: @molecule }
      else
        format.html { render action: "new" }
        format.json { render json: @molecule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /molecules/1
  # PUT /molecules/1.json
  def update
    @molecule = Molecule.find(params[:id])
    authorize! :update, @molecule

    respond_to do |format|
      if @molecule.update_attributes(params[:molecule])
        format.html { redirect_to @molecule, notice: 'Molecule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @molecule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /molecules/1
  # DELETE /molecules/1.json
  def destroy
    @molecule = Molecule.find(params[:id])
    authorize! :destroy, @molecule
    @molecule.destroy

    respond_to do |format|
      format.html { redirect_to molecules_url }
      format.json { head :no_content }
    end
  end
end

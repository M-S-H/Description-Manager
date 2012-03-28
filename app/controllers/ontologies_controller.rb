class OntologiesController < ApplicationController
  # GET /ontologies
  # GET /ontologies.json
  def index
    @ontologies = Ontology.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ontologies }
    end
  end

  # GET /ontologies/1
  # GET /ontologies/1.json
  def show
    @ontology = Ontology.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ontology }
    end
  end

  # GET /ontologies/new
  # GET /ontologies/new.json
  def new
    @ontology = Ontology.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ontology }
    end
  end

  # GET /ontologies/1/edit
  def edit
    @ontology = Ontology.find(params[:id])
  end

  # POST /ontologies
  # POST /ontologies.json
  def create
    @ontology = Ontology.new(params[:ontology])

	upload = params[:upload]

	name = upload['datafile'].original_filename

	@ontology.filetype = File.extname(name)
	@ontology.location = './public/ontology_files/' + @ontology.name + @ontology.filetype

	File.open(@ontology.location, 'wb') { |f| f.write(upload['datafile'].read) }


    respond_to do |format|
      if @ontology.save
        format.html { redirect_to @ontology, notice: 'Ontology was successfully created.' }
        format.json { render json: @ontology, status: :created, location: @ontology }
      else
        format.html { render action: "new" }
        format.json { render json: @ontology.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ontologies/1
  # PUT /ontologies/1.json
  def update
    @ontology = Ontology.find(params[:id])

    respond_to do |format|
      if @ontology.update_attributes(params[:ontology])
        format.html { redirect_to @ontology, notice: 'Ontology was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ontology.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ontologies/1
  # DELETE /ontologies/1.json
  def destroy
    @ontology = Ontology.find(params[:id])
	File.delete(@ontology.location)
    @ontology.destroy


    respond_to do |format|
      format.html { redirect_to ontologies_url }
      format.json { head :no_content }
    end
  end
end

require './app/lib/flounder/parser.rb'
require './app/lib/flounder/rectifier.rb'
require './app/lib/flounder/utilities.rb'

include Flounder::Utilities


class OntologicalDescriptionsController < ApplicationController
  # GET /ontological_descriptions
  # GET /ontological_descriptions.json
  def index
    @ontological_descriptions = OntologicalDescription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ontological_descriptions }
    end
  end

  # GET /ontological_descriptions/1
  # GET /ontological_descriptions/1.json
  def show
    @ontological_description = OntologicalDescription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ontological_description }
    end
  end

  # GET /ontological_descriptions/new
  # GET /ontological_descriptions/new.json
  def new
    @ontological_description = OntologicalDescription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ontological_description }
    end
  end

  # GET /ontological_descriptions/1/edit
  def edit
    @ontological_description = OntologicalDescription.find(params[:id])
  end

  # POST /ontological_descriptions
  # POST /ontological_descriptions.json
  def create

	@ontology = Ontology.find_by_id(params[:ontology_id])
    @ontological_description = OntologicalDescription.new(params[:ontological_description])

	parser = Flounder::Parser.new
	ont = File.new(@ontology.location)
	hash = parser.parse ont
	rectifier = Flounder::Rectifier.new
	od = rectifier.rectify hash[:elements], hash[:structure]

	@ontological_description.ontology_name = @ontology.name
	@ontological_description.name = symbolize hash[:elements].keys[0].split('#').first
	@ontological_description.location = './public/descriptions/' + @ontological_description.name + '.rb'

	File.open(@ontological_description.location, "w+") {|f| f.write(od)}

    respond_to do |format|
      if @ontological_description.save
        format.html { redirect_to @ontological_description, notice: 'Ontological description was successfully created.' }
        format.json { render json: @ontological_description, status: :created, location: @ontological_description }
      else
        format.html { render action: "new" }
        format.json { render json: @ontological_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ontological_descriptions/1
  # PUT /ontological_descriptions/1.json
  def update
    @ontological_description = OntologicalDescription.find(params[:id])

    respond_to do |format|
      if @ontological_description.update_attributes(params[:ontological_description])
        format.html { redirect_to @ontological_description, notice: 'Ontological description was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ontological_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ontological_descriptions/1
  # DELETE /ontological_descriptions/1.json
  def destroy
    @ontological_description = OntologicalDescription.find(params[:id])
	File.delete(@ontological_description.location)
    @ontological_description.destroy

    respond_to do |format|
      format.html { redirect_to ontological_descriptions_url }
      format.json { head :no_content }
    end
  end
end

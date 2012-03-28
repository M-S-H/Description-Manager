class OntologicalDescription
  include MongoMapper::Document

  key :ontology_name, String
  key :name, String
  key :location, String
  belongs_to :ontology

end

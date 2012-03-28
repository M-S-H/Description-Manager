class Ontology
  include MongoMapper::Document

  key :name, String
  key :filetype, String
  key :location, String
  one :OntologicalDescription

  validates_presence_of :name

end

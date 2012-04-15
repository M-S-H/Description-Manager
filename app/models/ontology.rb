class Ontology
  include MongoMapper::Document

  key :name, String
  key :filetype, String
  key :location, String
  one :ontological_description

  validates_presence_of :name

end

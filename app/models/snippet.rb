require 'elasticsearch/model'

class Snippet < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :name, :description, :content, presence: true

  def data
    content
  end

  def file_name
    name
  end

  def sanitized_file_name
    name.gsub(/[^a-zA-Z0-9_\-\.]+/, '')
  end
end

# Delete the previous articles index in Elasticsearch
Snippet.__elasticsearch__.client.indices.delete index: Snippet.index_name rescue nil

# Create the new index with the new mapping
Snippet.__elasticsearch__.client.indices.create \
  index: Snippet.index_name,
  body: { settings: Snippet.settings.to_hash, mappings: Snippet.mappings.to_hash }

# Index all article records from the DB to Elasticsearch
Snippet.import

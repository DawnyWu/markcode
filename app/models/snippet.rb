require 'elasticsearch/model'

class Snippet < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :author, class_name: 'User'

  validates :name, :description, :content, presence: true

  settings index: { number_of_shards: 1, number_of_replicas: 0 } do
    mapping do
      indexes :name , type: 'string', index: "not_analyzed"
      indexes :description, type: 'string', index: "not_analyzed"

      # indexes :title, type: 'multi_field' do
      #   indexes :title,     analyzer: 'snowball'
      #   indexes :tokenized, analyzer: 'simple'
      # end

      # indexes :content, type: 'multi_field' do
      #   indexes :content,   analyzer: 'snowball'
      #   indexes :tokenized, analyzer: 'simple'
      # end

      # indexes :published_on, type: 'date'

      # indexes :authors do
      #   indexes :full_name, type: 'multi_field' do
      #     indexes :full_name
      #     indexes :raw, analyzer: 'keyword'
      #   end
      # end

      # indexes :categories, analyzer: 'keyword'

      # indexes :comments, type: 'nested' do
      #   indexes :body, analyzer: 'snowball'
      #   indexes :stars
      #   indexes :pick
      #   indexes :user, analyzer: 'keyword'
      #   indexes :user_location, type: 'multi_field' do
      #     indexes :user_location
      #     indexes :raw, analyzer: 'keyword'
      #   end
      # end
    end
  end



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

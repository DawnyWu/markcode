require 'elasticsearch/model'
class Snippet < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  validates :content, presence: true
  def data
    content
  end
end

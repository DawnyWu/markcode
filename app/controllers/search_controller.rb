class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @snippets = []
    else
      @snippets = Snippet.search(params[:q]).records
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['name^10', 'description', 'content']
          }
        },
        highlight: {
          pre_tags: ['<em>'],
          post_tags: ['</em>'],
          fields: {
            name: {},
            description: {},
            content: {}
          }
        }
      }
    )
  end
end

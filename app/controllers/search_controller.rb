class SearchController < ApplicationController
  def search
    params[:q] = params[:term] if params[:term].present?
    if params[:q].nil?
      @snippets = []
    else
      @snippets = Snippet.search(params[:q]).records
    end

    descriptions_array = []

    if @snippets.present?
      snippets = @snippets[0..4]

      snippets.each do |s|
        descriptions_array << {label: s.description, url: "/snippets/#{s.id}"}
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: descriptions_array }
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

class SearchController < ApplicationController

  def search
    params[:q] = params[:term] if params[:term].present?

    @snippets = params[:q].nil? ? [] : current_user.snippets.where('description LIKE ?', "%#{params[:q]}%")

    descriptions_array = result_to_array(@snippets)

    respond_to do |format|
      format.html
      format.json { render json: descriptions_array }
    end
  end

  private

  def result_to_array(snippets)
    descriptions_array = []

    if snippets.present?
      snippets = @snippets[0..4]

      snippets.each do |s|
        descriptions_array << {label: s.description, url: "/snippets/#{s.id}"}
      end
    end

    descriptions_array
  end
end

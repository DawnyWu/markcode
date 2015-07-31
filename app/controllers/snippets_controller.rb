class SnippetsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create, :edit, :update, :destroy]
  before_action :find_snippet, only: [:show, :edit, :update, :raw, :destroy]

	def index
	  @snippets = current_user.snippets.page params[:page]
	end

  def new
  	@snippet = Snippet.new
  end

  def create
    snippet = current_user.snippets.create(snippet_params)
    redirect_to snippet_path(snippet)
  end

  def show
  end

  def edit
  end

  def update
    if @snippet.update(snippet_params)
      redirect_to snippet_path(@snippet)
    else
      render action: :edit
    end
  end

  def raw
    send_data(
      @snippet.content,
      type: 'text/plain; charset=utf-8',
      disposition: 'inline',
      filename: @snippet.sanitized_file_name
    )
  end

  def destroy
    Snippet.destroy(@snippet)
    redirect_to snippets_path
  end

  def import
    ImportGistsWorker.perform_async(session[:github_access_token], current_user.id)
    redirect_to snippets_path
  end

  private

  def snippet_params
    params.require(:snippet).permit(:content, :description, :name, :language)
  end

  def find_snippet
    @snippet = Snippet.find(params[:id])
  end
end

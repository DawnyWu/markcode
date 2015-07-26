class SnippetsController < ApplicationController
  before_action :find_snippet, only: [:show, :edit, :update, :raw]

	def index
	  @snippets = Snippet.all
	end

  def new
  	@snippet = Snippet.new
  end

  def create
    snippet = Snippet.create(snippet_params)
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

  private

  def snippet_params
    params.require(:snippet).permit(:content, :description, :name)
  end

  def find_snippet
    @snippet = Snippet.find(params[:id])
  end
end

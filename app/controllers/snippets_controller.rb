class SnippetsController < ApplicationController
  before_action :find_snippet, only: [:show, :edit, :update]

	def index
		@snippets = Snippet.all
	end

  def new
  	@snippet = Snippet.new
  end

  def create
    Snippet.create(snippet_params)
    redirect_to snippets_path

  	# pipeline = HTML::Pipeline.new [
		 #  HTML::Pipeline::MarkdownFilter,
		 #  HTML::Pipeline::SyntaxHighlightFilter
   #  ]
  	# content = params[:snippet][:content]
  	# result = pipeline.call(content)
  	# Snippet.create(name: params[:snippet][:name], content: result[:output].to_s)
   #  binding.pry
  	# redirect_to snippets_path
  end

  def show
  end

  def edit
  end

  def update
    @snippet.update(snippet_params)
    redirect_to snippets_path
  end

  private

  def snippet_params
    params.require(:snippet).permit(:content, :description, :name)
  end

  def find_snippet
    @snippet = Snippet.find(params[:id])
  end
end

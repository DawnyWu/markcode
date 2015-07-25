class SnippetsController < ApplicationController
	def index
		@snippets = Snippet.all
	end

  def new
  	@snippet = Snippet.new
  end

  def preview
  end

  def create
    binding.pry
    Snippet.create(snippet_params)
    redirect_to snippets_path
   #  params[:snippet][:content] = params[:snippet][:content].gsub "\n","\r\n"
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
    @snippet = Snippet.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def snippet_params
    params.require(:snippet).permit(:content, :description, :name)
  end
end

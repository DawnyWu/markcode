class SnippetsController < ApplicationController
	def index
		@snippets = Snippet.all
	end

  def new
  	@snippet = Snippet.new
  end

  def create
  	pipeline = HTML::Pipeline.new [
		  HTML::Pipeline::MarkdownFilter,
		  HTML::Pipeline::SyntaxHighlightFilter
    ]
  	content = params[:snippet][:content]
  	result = pipeline.call(content)
  	Snippet.create(name: params[:snippet][:name], content: result[:output].to_s)
  	redirect_to snippets_path
  end

  def show
  end

  def edit
  end

  def update
  end
end

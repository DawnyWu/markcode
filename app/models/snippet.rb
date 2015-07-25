class Snippet < ActiveRecord::Base
  validates :content, presence: true
  def data
    content
  end
end

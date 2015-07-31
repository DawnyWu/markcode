class ImportGistsWorker
  include Sidekiq::Worker

  def perform(access_token, user_id)
    client = Octokit::Client.new(access_token: access_token)
    # 30 items
    result = client.gists
    create_gists(result, user_id)
    last_response = client.last_response

    loop do
      break if last_response.rels[:next].nil?
      last_response = last_response.rels[:next].get
      result = last_response.data
      create_gists(result, user_id)
    end
  end

  private

  def create_gists(data, user_id)
    data.each do |d|
      file = d[:files].to_h.values[0]

      description = d[:description]
      name        = file[:filename]
      language    = file[:language].downcase if file[:language].present?
      content     = Faraday.get(file[:raw_url]).body.force_encoding("ASCII-8BIT")
                    .force_encoding("utf-8").rstrip

      User.find(user_id).snippets.create(
        name: name, language: language, content: content, description: description
      )
    end
  end
end
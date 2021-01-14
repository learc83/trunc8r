require 'rails_helper'

RSpec.describe 'Links', type: :request do
  describe 'Link creation' do
    it 'creates a new link and returns a slug' do
      headers = { 'ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json' }

      expect do
        post links_path params: { link: { url: 'http://google.com' } }, headers: headers
      end.to change { Link.count }.by(1)

      expect(response).to have_http_status(:created)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body)['slug']).to eql(Link.last.slug)
    end
  end
end

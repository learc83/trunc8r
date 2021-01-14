require 'rails_helper'

RSpec.describe 'Links', type: :request do
  describe 'Link creation' do
    it 'creates a new link and returns a slug' do
      headers = { 'ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json' }

      url = "https://google.com/test#{rand(999_999_999)}"

      expect do
        post links_path params: { link: { url: url } }, headers: headers
      end.to change { Link.count }.by(1)

      expect(Link.last.url).to eql(url)
      expect(response).to have_http_status(:created)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body)['slug']).to eql(Link.last.slug)
    end

    it 'returns an error if the url is blank' do
      headers = { 'ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json' }

      expect do
        post links_path params: { link: { url: '' } }, headers: headers
      end.to change { Link.count }.by(0)

      expect(response).to have_http_status(400)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body)['errors']).to include("Url can't be blank")
    end

    it 'returns an error if the url is invalid' do
      expect do
        post links_path params: { link: { url: 'htt://google.com' } }, headers: headers
      end.to change { Link.count }.by(0)

      expect(response).to have_http_status(400)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body)['errors']).to include('Url must be a valid url (must start with http(s)://)')
    end
  end
end

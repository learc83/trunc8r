require 'rails_helper'

RSpec.describe 'Redirects', type: :request do
  describe 'Visiting /:slug' do
    it 'redirects to the correct url' do
      link = Link.create(url: 'https://google.com')
      get "/#{link.slug}"

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(link.url)
    end

    it 'correctly handles a link with the slug "link"' do
      # 'link' is a valid base62 slug
      link = Link.create(url: 'https://google.com')
      link.update_columns(id: Link.slug_to_id('link'))

      get '/link'
      expect(response).to redirect_to(link.url)
    end
  end
end

require 'rails_helper'
require 'benchmark'

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

    it 'can handle at least 10 redirects per second' do
      link = Link.create(url: 'https://google.com')

      elapsed = Benchmark.realtime do
        10.times do
          get "/#{link.slug}"
          expect(response).to redirect_to(link.url)
        end
      end
      expect(elapsed).to be < 1.seconds
    end
  end
end

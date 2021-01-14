class LinksController < ApplicationController
  def create
    link = Link.create(url: 'http://test.com')
    render json: { slug: link.slug }, status: :created
  end
end

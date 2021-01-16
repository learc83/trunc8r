class LinksController < ApplicationController
  def create
    sleep 0.3

    link = Link.new(url: params[:link][:url])

    if link.save
      render json: { slug: link.slug }, status: :created
    else
      render json: { errors: link.errors.full_messages }, status: 400
    end
  end
end

class RedirectsController < ApplicationController
  def redirect
    id = Link.slug_to_id(params[:slug])
    link = Link.find(id)

    redirect_to link.url
  end
end

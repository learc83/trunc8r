require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'Index' do
    it 'loads index when visiting the root path' do
      get '/'

      expect(response).to have_http_status(:ok)
    end
  end
end

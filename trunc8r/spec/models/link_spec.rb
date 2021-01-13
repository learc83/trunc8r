require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'validations' do
    it "shouldn't allow a blank url" do
      link = Link.new
      expect(link.valid?).to be false
      expect(link.errors.messages[:url]).to include "can't be blank"
    end

    it "shouldn't only allow urls that start with http:// or https://" do
      error_message = ['must be a valid url (must start with http(s)://)']
      link = Link.new(url: 'google.com')
      expect(link.valid?).to be false
      expect(link.errors.messages[:url]).to eq error_message

      link = Link.new(url: 'htp://google.com')
      expect(link.valid?).to be false
      expect(link.errors.messages[:url]).to eq error_message

      link = Link.new(url: 'http://google.com')
      expect(link.valid?).to be true

      link = Link.new(url: 'https://google.com')
      expect(link.valid?).to be true
    end
  end
end

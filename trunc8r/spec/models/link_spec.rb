require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'validations' do
    it "doesn't allow a blank url" do
      link = Link.new
      expect(link.valid?).to be false
      expect(link.errors.messages[:url]).to include "can't be blank"
    end

    it 'only allow urls that start with http:// or https://' do
      error_message = ['must be a valid url ( must start with http(s):// )']
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

    it 'must not be only http:// or https://' do
      error_message = ['must be a valid url ( must start with http(s):// )']
      link = Link.new(url: 'http://')
      expect(link.valid?).to be false
      expect(link.errors.messages[:url]).to eq error_message

      link = Link.new(url: 'https://')
      expect(link.valid?).to be false
      expect(link.errors.messages[:url]).to eq error_message
    end
  end

  describe '.slug' do
    it 'returns the id as base62' do
      expect(Link.new(id: 1).slug).to eql '1'
      expect(Link.new(id: 123_456).slug).to eql 'W7E'
      expect(Link.new(id: 999_999_999).slug).to eql '15ftgF'
    end
  end

  describe '.slug_to_id' do
    it 'returns the id as base62' do
      expect(Link.slug_to_id('1')).to eql 1
      expect(Link.slug_to_id('W7E')).to eql 123_456
      expect(Link.slug_to_id('15ftgF')).to eql 999_999_999
    end
  end
end

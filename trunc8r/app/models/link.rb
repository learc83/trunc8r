class Link < ApplicationRecord
  validates :url, presence: true
  validates_format_of :url, with: %r{http(s)?://}, message: 'must be a valid url ( must start with http(s):// )'

  def self.slug_to_id(slug)
    slug.base62_decode
  end

  def slug
    id.base62_encode
  end
end

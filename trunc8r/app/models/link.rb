class Link < ApplicationRecord
  validates :url, presence: true
  validates_format_of :url, with: %r{http(s)?://}, message: 'must be a valid url (must start with http(s)://)'
end

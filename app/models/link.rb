class Link < ApplicationRecord
  validates :url, presence: true, :format => {:with => URI.regexp}

  DEFAULT_LENGTH_OF_UGLY = 4

  def self.shorten params
    create(params.merge({ugly_url: generate_ugly_url(params)}))
  end

  def generate_ugly_url params
    SecureRandom.hex(DEFAULT_LENGTH_OF_UGLY / 2)
  end
end

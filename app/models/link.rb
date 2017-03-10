class Link < ApplicationRecord
  validates :url, presence: true, format: {with: URI.regexp}
  validates :url, url: true
  validates_uniqueness_of :ugly_path
  validates_uniqueness_of :url_md5

  has_many :stats

  before_create :parse_url_response
  before_create :generate_ugly_path

  DEFAULT_UGLY_PATH_LENGTH = 3.freeze # The length of the result string is twice of n.
  MAX_CHECKING_TIMES = 5.freeze

  attr_accessor :url_response

  protected
    def generate_ugly_path
      length_of = Link.select("CHAR_LENGTH(ugly_path) as len").order("MAX(CHAR_LENGTH(ugly_path)) DESC").group("ugly_path").first
      length_of = length_of ? length_of.len / 2 : nil
      length_of ||= DEFAULT_UGLY_PATH_LENGTH

      i = 0
      self.ugly_path = loop do
        random_ugly_path = SecureRandom.hex(length_of.to_i)
        break random_ugly_path unless self.class.exists?(ugly_path: random_ugly_path)
        length_of += 1 if i == MAX_CHECKING_TIMES.to_i
        i += 1
      end
    end

    def parse_url_response
      if @url_response.is_a?(Net::HTTPSuccess)
        title = /<title>(.*?)<\/title>/.match(@url_response.body)
        if title && title.to_a[1].present?
          self.title = title.to_a[1].to_s
        end
      end
    end
end

require 'net/http'

class UrlValidator < ActiveModel::Validator
  def validate(record)
    result = true
    begin
      url = URI.parse(record.url)
      response = Net::HTTP.get_response(url)
      unless response.is_a?(Net::HTTPSuccess)
        record.errors.add(:url, :invalid)
        result = false
      end
      record.url_response = response
    rescue StandardError => error
      record.errors.add(:url, :invalid)
      result = false
    ensure
      return result
    end
  end
end

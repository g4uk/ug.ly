class Link < ApplicationRecord
  attr_accessor :url
  validates :url, presence: true, :format => {:with => URI.regexp}
  #
  # protected
  #   def contract_params
  #     params.require(:link).permit(:url)
  #   end
end

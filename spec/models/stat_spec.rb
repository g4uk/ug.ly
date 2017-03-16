require 'rails_helper'

RSpec.describe Stat, type: :model do
  it "should belongs to link" do
    should belong_to(:link)
  end
end

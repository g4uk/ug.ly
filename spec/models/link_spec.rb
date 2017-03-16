require 'rails_helper'

RSpec.describe Link, type: :model do
  context "is valid generate new link" do
    let(:url) { 'https://stackoverflow.com/' }
    let(:link) { Link.new(url: url, url_md5: Digest::MD5.hexdigest( url )) }

    it "is valid with valid url" do
      expect(link).to be_valid
    end

    it "should generate ugly_path" do
      expect{ link.save }.to change{ link.ugly_path }
    end
  end
  it "is not valid without a url" do
    link = Link.new(url: nil)
    expect(link).to_not be_valid
  end

  it "is not valid incorrenct url" do
    link = Link.new(url: 'fake')
    expect(link).to_not be_valid
  end

  it "is not valid redirect url" do
    link = Link.new(url: 'http://bit.ly/1gfGnc2')
    expect(link).to_not be_valid
  end

  it "is not valid without a url" do
    link = Link.new(url: nil)
    expect(link).to_not be_valid
  end

  it "should has many stats" do
    should have_many(:stats)
  end
end

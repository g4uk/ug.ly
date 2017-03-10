class Stat < ApplicationRecord
  belongs_to :link

  def self.add remote_ip, referer, user_agent
    attributes = { direct: referer.nil? }

    attributes.merge!( get_geo_attributes( remote_ip ) )
    attributes.merge!( get_referer_attributes( referer ) )
    attributes.merge!( get_browser_attributes( user_agent ) )
    attributes.merge!( get_user_agent_attributes( user_agent ) )

    create attributes
  end

  private
    def self.wrap_attributes resource
      attributes = {}
      unless resource.nil?
        attributes = yield( resource ) if block_given?
      end
      attributes
    end

    def self.get_geo_attributes remote_ip
      r = Geocoder.search(remote_ip).first
      wrap_attributes(r) do |r|
        return {
          remote_ip: r.ip,
          country: r.country,
          state: r.state,
          city: r.city
        }
      end
    end

    def self.get_referer_attributes referer
      rf = RefererParser::Parser.new.parse( referer ) rescue nil
      wrap_attributes(rf) do |rf|
        return {
          source: rf[:source],
          domain: rf[:domain]
        }
      end
    end

    def self.get_browser_attributes user_agent
      browser = Browser.new( user_agent ) rescue nil
      wrap_attributes(browser) do |browser|
        return {
          browser_name: browser.name,
          browser_version: browser.version,
          bot: browser.bot?,
          device_name: browser.device.name
        }
      end
    end

    def self.get_user_agent_attributes user_agent
      ua = UserAgentParser.parse( user_agent ) rescue nil
      wrap_attributes(ua) do |ua|
        return { os: ua.os.to_s }
      end
    end
end

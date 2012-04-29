require "cgi"
require "nokogiri"

module Komerci
  class Authorization
    attr_accessor :code, :order_number, :number, :receipt_number, :authentication_number, :sequential_number, :country_code
    attr_reader :message, :date

    def date=(value)
      @date = Date.parse(value)
    end

    def message=(value)
      @message = CGI.unescape(value)
    end

    def self.from_xml(string)
      xml = Nokogiri::XML(string)
      new.tap do |a|
        a.code = xml.at("CODRET").text
        a.message = xml.at("MSGRET").text
        a.order_number = xml.at("NUMPEDIDO").text
        a.date = xml.at("DATA").text
        a.number = xml.at("NUMAUTOR").text
        a.receipt_number = xml.at("NUMCV").text
        a.authentication_number = xml.at("NUMAUTENT").text
        a.sequential_number = xml.at("NUMSQN").text
        a.country_code = xml.at("ORIGEM_BIN").text
      end
    end
  end
end

require "spec_helper"

describe Komerci::Authorization do
  subject { Komerci::Authorization.new }

  it "#code" do
    subject.code = "0"
    subject.code.should == "0"
  end

  it "#message" do
    subject.message = "Autorizado+com+sucesso"
    subject.message.should == "Autorizado com sucesso"
  end

  it "#order_number" do
    subject.order_number = "1"
    subject.order_number.should == "1"
  end

  it "#date" do
    subject.date = "20120331"
    subject.date.should == Date.new(2012, 3, 31)
  end

  it "#number" do
    subject.number = "7022"
    subject.number.should == "7022"
  end

  it "#receipt_number" do
    subject.receipt_number = "1562"
    subject.receipt_number.should == "1562"
  end

  it "#authentication_number" do
    subject.authentication_number = "9320"
    subject.authentication_number.should == "9320"
  end

  it "#sequential_number" do
    subject.sequential_number = "9952"
    subject.sequential_number.should == "9952"
  end

  it "#country_code" do
    subject.country_code = "BRA"
    subject.country_code.should == "BRA"
  end

  describe "#from_xml" do
    subject { described_class.from_xml(File.read(File.expand_path("../../fixtures/authorization/success.xml", __FILE__))) }
    its(:code) { should == "0" }
    its(:message) { should == "Autorizado com sucesso" }
    its(:order_number) { should == "1" }
    its(:date) { should == Date.new(2012, 3, 31) }
    its(:number) { should == "7022" }
    its(:receipt_number) { should == "1562" }
    its(:authentication_number) { should == "9320" }
    its(:sequential_number) { should == "9952" }
    its(:country_code) { should == "BRA" }
  end
end




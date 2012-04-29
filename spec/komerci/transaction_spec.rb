require "spec_helper"

describe Komerci::Transaction do
  subject { described_class.new }

  it "#total" do
    subject.total = 1234.5
    subject.total.should == 1234.5
  end

  describe "#transaction" do
    it "accepts :a_vista" do
      subject.transaction = :a_vista
      subject.transaction.should == :a_vista
    end

    it "accepts :parcelado_emissor" do
      subject.transaction = :parcelado_emissor
      subject.transaction.should == :parcelado_emissor
    end

    it "accepts :parcelado_estabelecimento" do
      subject.transaction = :parcelado_estabelecimento
      subject.transaction.should == :parcelado_estabelecimento
    end

    it "accepts :pre_autorizacao" do
      subject.transaction = :pre_autorizacao
      subject.transaction.should == :pre_autorizacao
    end

    it "raises an error with invalid values" do
      expect { subject.transaction = :a_prazo }.should raise_error(Komerci::Transaction::InvalidTransaction, "a_prazo")
    end

    it "sets installments if value is :a_vista" do
      subject.transaction = :a_vista
      subject.installments.should == 0
    end
  end

  it "#installments" do
    subject.installments = 2
    subject.installments.should == 2
  end

  describe "#installments" do
    it "returns zero if #transaction is :a_vista" do
      subject.transaction = :a_vista

      subject.installments = 2
      subject.installments.should == 0
    end
  end

  it "#filiation_number" do
    subject.filiation_number = "123456789"
    subject.filiation_number.should == "123456789"
  end

  it "#order_number" do
    subject.order_number = "1"
    subject.order_number.should == "1"
  end

  it "#card_number" do
    subject.card_number = "4012001037141112"
    subject.card_number.should == "4012001037141112"
  end

  it "#card_code" do
    subject.card_code = "371"
    subject.card_code.should == "371"
  end

  it "#card_year" do
    subject.card_year = "2015"
    subject.card_year.should == "2015"
  end

  it "#card_month" do
    subject.card_month = "11"
    subject.card_month.should == "11"
  end

  it "#card_owner" do
    subject.card_owner = "Fulano de Tal"
    subject.card_owner.should == "Fulano de Tal"
  end

  describe "sending the authorization" do
    subject do
      described_class.new.tap do |a|
        a.total = "100.0"
        a.transaction = :a_vista
        a.filiation_number = "123456789"
        a.order_number = "1"
        a.card_number = "4012001037141112"
        a.card_code = "371"
        a.card_year = "2015"
        a.card_month = "11"
        a.card_owner = "Fulano de Tal"
      end
    end

    it "makes a request against komerci webservice" do
      stub_request(:post, "https://ecommerce.redecard.com.br/pos_virtual/wskomerci/cap_teste.asmx/GetAuthorizedTst").
        with(
          :body => {"AddData"=>"", "Ano"=>"2015", "CVC2"=>"371", "Concentrador"=>"", "ConfTxn"=>"", "Distribuidor"=>"", "Entrada"=>"", "Filiacao"=>"123456789", "IATA"=>"", "Mes"=>"11", "Nrcartao"=>"4012001037141112", "NumPedido"=>"1", "Numdoc1"=>"", "Numdoc2"=>"", "Numdoc3"=>"", "Numdoc4"=>"", "Parcelas"=>"00", "Pax1"=>"", "Pax2"=>"", "Pax3"=>"", "Pax4"=>"", "Portador"=>"Fulano de Tal", "TaxaEmbarque"=>"", "Total"=>"100.00", "Transacao"=>"04"},
        ).
        to_return(
          :status => 200,
          :body => File.read(File.expand_path("../../fixtures/authorization/success.xml", __FILE__)),
          :headers => { "Content-Type" => "text/xml" }
        )

      authorization = subject.send
      authorization.should be_instance_of(Komerci::Authorization)
    end
  end
end

require "rest-client"

module Komerci
  class Transaction
    class InvalidTransaction < StandardError; end

    ALLOWED_TRANSACTIONS = {
      :a_vista => "04",
      :parcelado_emissor => "06",
      :parcelado_estabelecimento => "08",
      :pre_autorizacao => "73"
    }

    attr_accessor :total, :filiation_number, :order_number, :card_number, :card_code, :card_year, :card_month, :card_owner
    attr_reader :transaction, :installments

    def transaction=(value)
      raise InvalidTransaction, value unless ALLOWED_TRANSACTIONS.include?(value)
      @transaction = value
      @installments = 0 if @transaction == :a_vista
    end

    def installments=(value)
      value = 0 if transaction == :a_vista
      @installments = value
    end

    def send
      uri = "https://ecommerce.redecard.com.br/pos_virtual/wskomerci/cap_teste.asmx/GetAuthorizedTst"
      # uri = URI(uri)
      params = {
        :Total => "%.2f" % total,
        :Transacao => ALLOWED_TRANSACTIONS[transaction],
        :Parcelas => "%02d" % installments,
        :Filiacao => filiation_number,
        :NumPedido => order_number,
        :Nrcartao => card_number,
        :CVC2 => card_code,
        :Mes => card_month,
        :Ano => card_year,
        :Portador => card_owner,

        :IATA => "",
        :Distribuidor => "",
        :Concentrador => "",
        :TaxaEmbarque => "",
        :Entrada => "",
        :Pax1 => "",
        :Pax2 => "",
        :Pax3 => "",
        :Pax4 => "",
        :Numdoc1 => "",
        :Numdoc2 => "",
        :Numdoc3 => "",
        :Numdoc4 => "",
        :ConfTxn => "",
        :AddData => ""
      }

      response = RestClient.post(uri, params)
      Authorization.from_xml(response)
    end
  end
end

require_relative "./reserva.rb"

class Locacao < Reserva
  def initialize(cliente, veiculo, data_inicio, data_fim)
    super(cliente, veiculo, data_inicio, data_fim)
  end

  def realiza_pagamento
    Pagamento.new(self, @data_fim, @preco)
  end
end

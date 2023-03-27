class Pagamento
  attr_accessor :reserva, :data, :valor

  def initialize(reserva, data, valor)
    @reserva = reserva
    @data = data
    @valor = valor
  end
end

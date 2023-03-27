class Pagamento
  attr_accessor :locacao, :data, :preco

  def initialize(locacao, data, preco)
    @locacao = locacao
    @data = data
    @preco = preco
  end
end

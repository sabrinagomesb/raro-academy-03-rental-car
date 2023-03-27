class Estoque
  attr_accessor :veiculos

  def initialize
    @veiculos = []
  end

  def cadastra_veiculo(veiculo)
    raise ErroValidacao.new("O parametro informado não é um veículo") if veiculo.class != Veiculo

    raise ErroValidacao.new("Veiculo já está cadastrado") if @veiculos.include?(veiculo)

    @veiculos << veiculo
  end

  def remove_veiculo(veiculo)
    raise ErroValidacao.new("Veículo não está disponível no estoque, por isso não pode ser removido") if veiculo.disponivel == false

    raise ErroValidacao.new("Veículo informado não existe no estoque.") unless @veiculos.include?(veiculo)

    @veiculos.delete(veiculo)
  end
end

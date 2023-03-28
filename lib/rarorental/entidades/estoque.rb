class Estoque
  attr_accessor :veiculos

  def initialize
    @veiculos = []
  end

  def veiculos_disponiveis(data_inicio, data_fim)
    raise ErroValidacao.new("Os parâmetros devem ser datas") if data_inicio.class != Date || data_fim.class != Date

    veiculos_disponiveis = []

    @veiculos.each do |veiculo|
      veiculos_disponiveis << veiculo if veiculo.disponivel?(data_inicio, data_fim)
    end

    veiculos_disponiveis
  end

  def cadastra_veiculo(veiculo)
    raise ErroValidacao.new("O parametro informado não é um veículo") if veiculo.class != Veiculo

    raise ErroValidacao.new("Veiculo já está cadastrado") if @veiculos.include?(veiculo)

    @veiculos << veiculo
  end

  def remove_veiculo(veiculo)
    raise ErroValidacao.new("Veículo informado não existe no estoque.") unless @veiculos.include?(veiculo)

    raise ErroValidacao.new("Veículo não está disponível no estoque, por isso não pode ser removido") unless veiculo.reservas.empty? && veiculo.locacoes.empty?

    @veiculos.delete(veiculo)
  end
end

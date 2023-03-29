class Estoque
  attr_reader :veiculos, :precos

  def initialize
    @veiculos = []
    @precos = Hash.new { |hash, key| hash[key] = Hash.new { |hash, key| hash[key] = 0 } }
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
    gera_precos
  end

  def remove_veiculo(veiculo)
    raise ErroValidacao.new("Veículo informado não existe no estoque.") unless @veiculos.include?(veiculo)

    raise ErroValidacao.new("Veículo não está disponível no estoque, por isso não pode ser removido") unless veiculo.reservas.empty? && veiculo.locacoes.empty?

    @veiculos.delete(veiculo)
    gera_precos
  end

  def atualiza_diaria_veiculo(veiculo, diaria_padrao)
    busca_veiculo = @veiculos.find { |e| e == veiculo }

    raise ErroValidacao.new("Veículo informado não existe no estoque.") unless busca_veiculo

    busca_veiculo.atualiza_diarias(diaria_padrao)
    gera_precos
  end

  def imprime_tabela_precos
    cabecalho = "| Modelo                                   | Diária Padrão |  Diária Desconto  |\n"
    divisoria = "|------------------------------------------|---------------|-------------------|\n"

    dados = @precos.map do |key, value|
      "| #{value[:modelo].ljust(40)} | #{value[:diaria_padrao].to_s.ljust(13)} | #{value[:diaria_desconto].to_s.ljust(17)} |\n"
    end

    tabela = divisoria + cabecalho + divisoria + dados.join + divisoria
    print tabela
  end

  private

  def gera_precos
    @veiculos.map do |veiculo|
      @precos[veiculo.placa][:modelo] = "#{veiculo.fabricante} #{veiculo.modelo} - #{veiculo.ano}"
      @precos[veiculo.placa][:diaria_padrao] = veiculo.diaria_padrao
      @precos[veiculo.placa][:diaria_desconto] = veiculo.diaria_desconto
    end
  end
end

class Veiculo
  attr_accessor :placa, :fabricante, :modelo, :ano,
                :diaria_padrao, :diaria_desconto,
                :reservas, :locacoes

  def initialize(placa, fabricante, modelo, ano, diaria_padrao)
    valida(placa)
    @placa = placa
    @fabricante = fabricante
    @modelo = modelo
    @ano = ano
    @diaria_padrao = diaria_padrao.to_f
    @diaria_desconto = (diaria_padrao * 0.9).to_f
    @reservas = []
    @locacoes = []
  end

  def disponivel?(data_inicio, data_fim)
    raise ErroValidacao.new("Os parâmetros devem ser datas") if data_inicio.class != Date || data_fim.class != Date

    busca_disponibilidade(@locacoes, data_inicio, data_fim) &&
    busca_disponibilidade(@reservas, data_inicio, data_fim)
  end

  private

  def valida(placa)
    raise ErroValidacao.new("Placa deve conter 3 digitos alfanumericos seguidos de hifen e 4 digitos alfanumericos. Ex: CAR-1234") unless placa.match?(/^[[:alnum:]]{3}-[[:alnum:]]{4}$/)
  end

  def busca_disponibilidade(lista, data_inicio, data_fim)
    lista.each do |item|
      if data_inicio > item.data_fim || data_fim < item.data_inicio
        return true
      elsif data_inicio.between?(item.data_inicio, item.data_fim) || data_fim.between?(item.data_inicio, item.data_fim)
        return false
      end
    end
    true
  end
end

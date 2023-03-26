class Veiculo
  attr_accessor :placa, :fabricante, :modelo, :ano,
                :diaria_padrao, :diaria_desconto, :disponivel

  def initialize(placa, fabricante, modelo, ano, diaria_padrao)
    valida(placa)
    @placa = placa
    @fabricante = fabricante
    @modelo = modelo
    @ano = ano
    @diaria_padrao = diaria_padrao.to_f
    @diaria_desconto = (diaria_padrao * 0.9).to_f
    @disponivel = true
  end

  private

  def valida(placa)
    raise ErroValidacao.new("Placa deve conter 3 digitos alfanumericos seguidos de hifen e 4 digitos alfanumericos. Ex: CAR-1234") unless placa.match?(/^[[:alnum:]]{3}-[[:alnum:]]{4}$/)
  end
end

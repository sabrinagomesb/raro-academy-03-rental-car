class Reserva
  attr_reader :cliente, :veiculo, :preco,
              :data_inicio, :data_fim

  def initialize(cliente, veiculo, data_inicio, data_fim)
    @cliente = cliente
    @veiculo = veiculo
    @data_inicio = data_inicio
    @data_fim = data_fim
    @preco = calcula_preco
  end

  def calcula_preco
    total_dias = (@data_fim - @data_inicio).to_i
    diaria_padrao = @veiculo.diaria_padrao
    diaria_desconto = @veiculo.diaria_desconto

    if total_dias <= 6
      diaria_padrao * total_dias
    else
      diaria_desconto * total_dias
    end
  end
end

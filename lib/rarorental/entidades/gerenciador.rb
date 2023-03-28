class Gerenciador
  attr_accessor :estoque, :clientes, :pagamentos,
                :reservas, :locacoes, :status

  def initialize
    @clientes = []
    @reservas = []
    @locacoes = []
    @pagamentos = []
    @status = Hash.new { |hash, key| hash[key] = nil }
  end

  def cadastra_reserva(reserva)
    cliente = reserva.cliente
    veiculo = reserva.veiculo
    data_inicio = reserva.data_inicio
    data_fim = reserva.data_fim

    raise ErroValidacao.new("Cliente já possuiu reserva ou locacao no momento") if @status.has_key?(cliente.cpf)

    raise ErroValidacao.new("Veiculo indisponivel nas datas da reserva solicitada") unless veiculo.disponivel?(data_inicio, data_fim)

    @reservas << reserva
    veiculo.reservas << reserva
    cliente.reservas << reserva
    @status[cliente.cpf] = reserva
  end

  def cancela_reserva(reserva)
  end

  def inicia_locacao(reserva)
  end

  def finaliza_locacao(locacao)
  end

  def cadastra_cliente(cliente)
    raise ErroValidacao.new("O parametro informado não é um cliente") if cliente.class != Cliente

    raise ErroValidacao.new("Cliente já está cadastrado") if @clientes.include?(cliente)

    @clientes << cliente
  end

  def atualiza_cliente(cliente, novo_nome)
    busca_cliente = @clientes.find { |e| e == cliente }

    raise ErroValidacao.new("Cliente não encontrado") unless busca_cliente

    busca_cliente.atualiza_cadastro(novo_nome)
  end

  def remove_cliente(cliente)
    raise ErroValidacao.new("Cliente não encontrado") unless @clientes.include?(cliente)

    raise ErroValidacao.new("Cliente possui reserva/locacao, por isso não pode ser excluído da lista de clientes") unless cliente.reservas.empty? && cliente.locacoes.empty?

    @clientes.delete(cliente)
  end
end

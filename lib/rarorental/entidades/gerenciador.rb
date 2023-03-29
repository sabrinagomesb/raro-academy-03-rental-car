class Gerenciador
  attr_accessor :estoque, :clientes,
                :pagamentos, :faturamento,
                :reservas, :locacoes, :status

  def initialize
    @clientes = []
    @reservas = []
    @locacoes = []
    @pagamentos = []
    @status = Hash.new { |hash, key| hash[key] = nil }
    @faturamento = Hash.new { |hash, key| hash[key] = Hash.new { |hash, key| hash[key] = 0 } }
  end

  def cadastra_reserva(reserva)
    raise ErroValidacao.new("Cliente já possuiu reserva ou locacao no momento") if @status.has_key?(reserva.cliente.cpf)

    raise ErroValidacao.new("Veiculo indisponivel nas datas da reserva solicitada") unless reserva.veiculo.disponivel?(reserva.data_inicio, reserva.data_fim)

    @reservas << reserva
    reserva.veiculo.reservas << reserva
    reserva.cliente.reservas << reserva
    @status[reserva.cliente.cpf] = reserva
  end

  def cancela_reserva(reserva)
    raise ErroValidacao.new("Reserva não cadastrada") unless @reservas.include?(reserva)

    raise ErroValidacao.new("Reserva só pode ser cancelada 1 dia antes da data de inicio") if Date.today > reserva.data_inicio - 1

    @reservas.delete(reserva)
    reserva.veiculo.reservas.delete(reserva)
    reserva.cliente.reservas.delete(reserva)
    @status.delete(reserva.cliente.cpf)
  end

  def inicia_locacao(reserva)
    raise ErroValidacao.new("Reserva não cadastrada") unless @reservas.include?(reserva)

    locacao = Locacao.new(reserva.cliente, reserva.veiculo, reserva.data_inicio, reserva.data_fim)

    cancela_reserva(reserva)

    @locacoes << locacao
    locacao.veiculo.locacoes << locacao
    locacao.cliente.locacoes << locacao
    @status[locacao.cliente.cpf] = locacao

    locacao
  end

  def finaliza_locacao(locacao)
    raise ErroValidacao.new("Locação não inicializada") unless @locacoes.include?(locacao)

    @status.delete(locacao.cliente.cpf)

    pagamento = Pagamento.new(locacao, locacao.data_fim, locacao.preco)
    @pagamentos << pagamento
    gera_faturamento
    pagamento
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

  private

  def gera_faturamento
    @pagamentos.map do |pagamento|
      data = pagamento.data
      preco = pagamento.preco

      @faturamento[data.year][data.mon] += preco
    end
  end
end

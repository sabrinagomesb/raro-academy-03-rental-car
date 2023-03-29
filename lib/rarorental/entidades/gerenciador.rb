class Gerenciador
  attr_accessor :estoque
  attr_reader :clientes, :ranking,
              :pagamentos, :faturamento,
              :reservas, :locacoes, :status

  def initialize
    @clientes = []
    @reservas = []
    @locacoes = []
    @pagamentos = []
    @ranking = Hash.new { |hash, key| hash[key] = 0 }
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
    gera_ranking
  end

  def cancela_reserva(reserva)
    raise ErroValidacao.new("Reserva não cadastrada") unless @reservas.include?(reserva)

    raise ErroValidacao.new("Reserva só pode ser cancelada 1 dia antes da data de inicio") if Date.today > reserva.data_inicio - 1

    @reservas.delete(reserva)
    reserva.veiculo.reservas.delete(reserva)
    reserva.cliente.reservas.delete(reserva)
    @status.delete(reserva.cliente.cpf)
    gera_ranking
  end

  def inicia_locacao(reserva)
    raise ErroValidacao.new("Reserva não cadastrada") unless @reservas.include?(reserva)

    locacao = Locacao.new(reserva.cliente, reserva.veiculo, reserva.data_inicio, reserva.data_fim)

    cancela_reserva(reserva)

    @locacoes << locacao
    locacao.veiculo.locacoes << locacao
    locacao.cliente.locacoes << locacao
    @status[locacao.cliente.cpf] = locacao
    gera_ranking

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

  def imprime_faturamento
    cabecalho = "| Ano  | Mes |    Valor Total    |\n"
    divisoria = "|------|-----|-------------------|\n"

    dados = @faturamento.map do |ano, meses|
      meses_strings = []

      meses.each do |mes, valor|
        string = "| #{@faturamento.key(meses)} | #{mes.to_s.ljust(3)} | #{formata_em_real(valor).ljust(17)} |\n"
        meses_strings << string

        string += "#{meses.key(valor)}"
        string += "#{valor}"
      end
      meses_strings
    end

    tabela = divisoria + cabecalho + divisoria + dados.flatten.join + divisoria

    print tabela
    tabela
  end

  def imprime_ranking
    titulo = "|                                MODELOS MAIS QUERIDOS                              |\n"
    cabecalho = "|  #  | Fabricante           | Modelo          | Ano  | Reservas | Locações | Total |\n"
    divisoria = "|-----|----------------------|-----------------|------|----------|----------|-------|\n"
    barra = "|-----------------------------------------------------------------------------------|\n"

    dados = @ranking.map do |key, value|
      "|  #{value}  | #{key.fabricante.ljust(20)} | #{key.modelo.ljust(15)} | #{key.ano} | #{key.reservas.size.to_s.ljust(8)} | #{key.locacoes.size.to_s.ljust(8)} | #{(key.locacoes.size + key.reservas.size).to_s.ljust(5)} |\n"
    end

    tabela = barra + titulo + barra + cabecalho + divisoria + dados.join + divisoria

    print tabela
    tabela
  end

  private

  def gera_ranking
    @ranking = Hash.new { |hash, key| hash[key] = 0 }

    @reservas.map do |reserva|
      @ranking[reserva.veiculo] += 1
    end
    @locacoes.map do |locacao|
      @ranking[locacao.veiculo] += 1
    end
  end

  def gera_faturamento
    @pagamentos.map do |pagamento|
      data = pagamento.data
      preco = pagamento.preco

      @faturamento[data.year][data.mon] += preco
    end
  end

  def formata_em_real(valor)
    "R$ #{"%.2f" % valor}".gsub(".", ",").reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse
  end
end

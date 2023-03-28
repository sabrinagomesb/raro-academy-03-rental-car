class Gerenciador
  attr_accessor :estoque, :clientes, :reservas, :locacoes

  def initialize
    @clientes = []
    # @reservas = []
    # @locacoes = []
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

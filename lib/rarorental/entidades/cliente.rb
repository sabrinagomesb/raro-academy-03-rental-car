class Cliente
  attr_reader :cpf, :nome,
              :reservas, :locacoes

  def initialize(cpf, nome)
    valida(cpf, nome)

    @cpf = cpf
    @nome = nome
    @reservas = []
    @locacoes = []
  end

  def atualiza_cadastro(novo_nome)
    valida(@cpf, novo_nome)
    @nome = novo_nome
  end

  private

  def valida(cpf, nome)
    raise ErroValidacao.new("Não pode ser inicializado um cliente sem nome") if nome.nil? || nome.empty?

    raise ErroValidacao.new("Um cliente deve ter cpf com 11 caracteres numéricos") unless cpf.match?(/^\d{11}$/)
  end
end

class Cliente
  attr_reader :cpf, :nome

  def initialize(cpf, nome)
    valida(cpf, nome)
    @cpf = cpf
    @nome = nome
  end

  def atualiza_cadastro(cpf, nome)
    valida(cpf, nome)
    @cpf = cpf
    @nome = nome
  end

  private

  def valida(cpf, nome)
    raise ErroValidacao.new("Não pode ser inicializado um cliente sem nome") if nome.nil? || nome.empty?

    raise ErroValidacao.new("Um cliente deve ter cpf com 11 caracteres numéricos") unless cpf.match?(/^\d{11}$/)
  end
end

RSpec.describe Cliente do
  describe "Initialize" do
    let(:cliente) { Cliente.new("11122233300", "Joao Silva") }

    context "Quando dado parametros válidos" do
      it "Deve inicializar um cliente" do
        expect(cliente.class).to eq(Cliente)
        expect(cliente.cpf).to eq("11122233300")
        expect(cliente.nome).to eq("Joao Silva")
        expect(cliente.reservas).to eq([])
        expect(cliente.locacoes).to eq([])
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro quando nome for vazio ou nulo" do
        mensagem_erro = "Não pode ser inicializado um cliente sem nome"

        expect { Cliente.new("22233344400", "") }.to raise_error(ErroValidacao, mensagem_erro)
        expect { Cliente.new("22233344400", nil) }.to raise_error(ErroValidacao, mensagem_erro)
      end

      it "Deve lançar erro quando cpf não tiver 11 caracteres numéricos" do
        mensagem_erro = "Um cliente deve ter cpf com 11 caracteres numéricos"

        expect { Cliente.new("222333444", "Jose Silva") }.to raise_error(ErroValidacao, mensagem_erro)
        expect { Cliente.new("2223334440011", "Jose Silva") }.to raise_error(ErroValidacao, mensagem_erro)
        expect { Cliente.new("222333444a1", "Jose Silva") }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end

  describe "Atualiza cadastro" do
    let(:cliente) { Cliente.new("55566677788", "Maria Sousa") }

    context "Quando dado parametros válidos" do
      it "Deve alterar o nome" do
        cliente.atualiza_cadastro("Mariana Sousa")

        expect(cliente.nome).to eq("Mariana Sousa")
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro quando nome for vazio ou nulo" do
        mensagem_erro = "Não pode ser inicializado um cliente sem nome"
        expect { cliente.atualiza_cadastro("") }.to raise_error(ErroValidacao, mensagem_erro)
        expect { cliente.atualiza_cadastro(nil) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end
end

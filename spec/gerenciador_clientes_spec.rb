RSpec.describe "Gerenciador - Cliente" do
  describe "Cadastra cliente" do
    let(:gerenciador) { Gerenciador.new }

    context "Quando dado parametros válidos" do
      it "Deve adicionar cliente na lista de Clientes" do
        cliente = Cliente.new("11122233355", "Tereza Silva")
        gerenciador.cadastra_cliente(cliente)

        expect(gerenciador.clientes.include?(cliente)).to eq(true)
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro caso o parametro não seja um Cliente" do
        mensagem_erro = "O parametro informado não é um cliente"

        expect { gerenciador.cadastra_cliente("Tereza Silva") }.to raise_error(ErroValidacao, mensagem_erro)
        expect { gerenciador.cadastra_cliente(11122233355) }.to raise_error(ErroValidacao, mensagem_erro)
      end

      it "Deve lançar erro se o cliente já estiver cadastrado" do
        cliente = Cliente.new("04411125677", "Rodrigo Sol")
        gerenciador.cadastra_cliente(cliente)
        expect(gerenciador.clientes.include?(cliente)).to eq(true)

        mensagem_erro = "Cliente já está cadastrado"
        expect { gerenciador.cadastra_cliente(cliente) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end

  describe "Atualiza cliente" do
    let(:gerenciador) { Gerenciador.new }

    context "Quando dado parametros válidos" do
      it "Deve atualizar nome do cliente" do
        cliente = Cliente.new("11122233355", "Tereza Silva")
        gerenciador.cadastra_cliente(cliente)
        expect(gerenciador.clientes.include?(cliente)).to eq(true)

        novo_nome = "Terezinha"

        gerenciador.atualiza_cliente(cliente, novo_nome)
        cliente_atualizado = gerenciador.clientes.find { |e| e == cliente }

        expect(cliente_atualizado.nome).to eq(novo_nome)
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro se o cliente não estiver cadastrado" do
        cliente = Cliente.new("04411125677", "Rodrigo Sol")
        expect(gerenciador.clientes.include?(cliente)).to eq(false)

        novo_nome = "Rodrigo Lua"
        mensagem_erro = "Cliente não encontrado"

        expect { gerenciador.atualiza_cliente(cliente, novo_nome) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end

  describe "Remove cliente" do
    let(:gerenciador) { Gerenciador.new }

    context "Quando dado parametros válidos" do
      it "Deve remover cliente da lista de Clientes" do
        cliente = Cliente.new("04411125677", "Rodrigo Sol")
        gerenciador.cadastra_cliente(cliente)
        expect(gerenciador.clientes.include?(cliente)).to eq(true)

        gerenciador.remove_cliente(cliente)
        expect(gerenciador.clientes.include?(cliente)).to eq(false)
      end
    end

    context "Quando dado parametros inválidos" do
      let(:cliente) { Cliente.new("04411125677", "Rodrigo Sol") }
      let(:veiculo) { Veiculo.new("CAR-1234", "Fiat", "Toro", 2021, 400) }
      let(:data_inicio) { Date.new(2022, 01, 15) }
      let(:data_fim) { Date.new(2022, 01, 20) }
      let(:reserva) { Reserva.new(cliente, veiculo, data_inicio, data_fim) }
      let(:locacao) { Locacao.new(cliente, veiculo, data_inicio, data_fim) }

      it "Deve lançar erro se o cliente já estiver realizado uma reserva" do
        gerenciador.cadastra_cliente(cliente)
        expect(gerenciador.clientes.include?(cliente)).to eq(true)

        cliente.reservas << reserva

        mensagem_erro = "Cliente possui reserva/locacao, por isso não pode ser excluído da lista de clientes"

        expect { gerenciador.remove_cliente(cliente) }.to raise_error(ErroValidacao, mensagem_erro)
      end

      it "Deve lançar erro se o cliente já estiver realizado uma locação" do
        gerenciador.cadastra_cliente(cliente)
        expect(gerenciador.clientes.include?(cliente)).to eq(true)

        cliente.locacoes << locacao

        mensagem_erro = "Cliente possui reserva/locacao, por isso não pode ser excluído da lista de clientes"

        expect { gerenciador.remove_cliente(cliente) }.to raise_error(ErroValidacao, mensagem_erro)
      end

      it "Deve lançar erro se o cliente não estiver na lista de clientes" do
        cliente = Cliente.new("04411125677", "Rodrigo Sol")
        gerenciador.cadastra_cliente(cliente)
        expect(gerenciador.clientes.include?(cliente)).to eq(true)

        gerenciador.remove_cliente(cliente)

        mensagem_erro = "Cliente não encontrado"
        expect { gerenciador.remove_cliente(cliente) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end
end

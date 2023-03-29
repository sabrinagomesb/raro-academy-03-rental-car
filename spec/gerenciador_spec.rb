RSpec.describe "Gerenciador - Cliente" do
  describe "Cadastra reserva" do
    let(:gerenciador) { Gerenciador.new }
    let(:estoque) { Estoque.new }
    let(:cliente) { Cliente.new("11122233300", "Joao Silva") }
    let(:veiculo) { Veiculo.new("CAR-1234", "Fiat", "Mobi", 2020, 100) }
    let(:data_inicio) { Date.new(2022, 01, 15) }
    let(:data_fim) { Date.new(2022, 01, 20) }
    let(:reserva) { Reserva.new(cliente, veiculo, data_inicio, data_fim) }

    context "Quando dado parametros válidos" do
      it "Deve cadastrar reserva" do
        gerenciador.estoque = estoque
        estoque.veiculos << veiculo
        gerenciador.cadastra_reserva(reserva)

        expect(gerenciador.reservas.include?(reserva)).to eq(true)
        expect(veiculo.reservas.include?(reserva)).to eq(true)
        expect(cliente.reservas.include?(reserva)).to eq(true)
        expect(gerenciador.status.has_key?(cliente.cpf)).to eq(true)
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro caso o cliente possua reserva/locacao ativa" do
        gerenciador.estoque = estoque
        estoque.veiculos << veiculo
        gerenciador.cadastra_reserva(reserva)
        expect(cliente.reservas.include?(reserva)).to eq(true)
        expect(gerenciador.status.has_key?(cliente.cpf)).to eq(true)

        outra_reserva = Reserva.new(
          cliente,
          Veiculo.new("CAR-1134", "Fiat", "Argo", 2022, 200),
          Date.new(2023, 01, 17),
          Date.new(2023, 01, 25)
        )
        mensagem_erro = "Cliente já possuiu reserva ou locacao no momento"

        expect { gerenciador.cadastra_reserva(outra_reserva) }.to raise_error(ErroValidacao, mensagem_erro)
      end

      it "Deve lançar erro se o veiculo estiver indisponível" do
        gerenciador.estoque = estoque
        estoque.veiculos << veiculo
        gerenciador.cadastra_reserva(reserva)
        expect(veiculo.reservas.include?(reserva)).to eq(true)

        outra_reserva_1 = Reserva.new(
          Cliente.new("04025896300", "Paulo Fernandes"),
          veiculo,
          Date.new(2022, 01, 17),
          Date.new(2022, 01, 25)
        )
        outra_reserva_2 = Reserva.new(
          Cliente.new("12112112122", "Breno"),
          veiculo,
          Date.new(2022, 01, 1),
          Date.new(2022, 01, 15)
        )
        mensagem_erro = "Veiculo indisponivel nas datas da reserva solicitada"

        expect { gerenciador.cadastra_reserva(outra_reserva_1) }.to raise_error(ErroValidacao, mensagem_erro)
        expect { gerenciador.cadastra_reserva(outra_reserva_2) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end

  describe "Cancela reserva" do
    before(:context) do
      @gerenciador = Gerenciador.new
      @estoque = Estoque.new
      @cliente = Cliente.new("11122233300", "Joao Silva")
      @veiculo = Veiculo.new("CAR-1234", "Fiat", "Mobi", 2020, 100)
      @data_inicio = Date.today + 5
      @data_fim = Date.today + 10
      @reserva = Reserva.new(@cliente, @veiculo, @data_inicio, @data_fim)

      @gerenciador.estoque = @estoque
      @estoque.veiculos << @veiculo
      @gerenciador.cadastra_reserva(@reserva)
      expect(@gerenciador.reservas.include?(@reserva)).to eq(true)
    end

    context "Quando dado parametros válidos" do
      it "Deve cancelar reserva" do
        @gerenciador.cancela_reserva(@reserva)

        expect(@gerenciador.reservas.include?(@reserva)).to eq(false)
        expect(@veiculo.reservas.include?(@reserva)).to eq(false)
        expect(@cliente.reservas.include?(@reserva)).to eq(false)
        expect(@gerenciador.status.has_key?(@cliente.cpf)).to eq(false)
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro se a reserva não estiver cadastrada" do
        # byebug
        mensagem_erro = "Reserva não cadastrada"

        expect { @gerenciador.cancela_reserva(@reserva) }.to raise_error(ErroValidacao, mensagem_erro)
      end

      it "Deve lançar erro se a reserva estiver fora do prazo de cancelamento" do
        reserva_1 = Reserva.new(@cliente, @veiculo, Date.today - 10, Date.today - 5)
        @gerenciador.cadastra_reserva(reserva_1)
        expect(@gerenciador.reservas.include?(reserva_1)).to eq(true)

        mensagem_erro = "Reserva só pode ser cancelada 1 dia antes da data de inicio"

        expect { @gerenciador.cancela_reserva(reserva_1) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end

  describe "Inicia locacao" do
    before(:context) do
      @gerenciador = Gerenciador.new
      @estoque = Estoque.new
      @cliente = Cliente.new("11122233300", "Joao Silva")
      @veiculo = Veiculo.new("CAR-1234", "Fiat", "Mobi", 2020, 100)
      @data_inicio = Date.today + 5
      @data_fim = Date.today + 10
      @reserva = Reserva.new(@cliente, @veiculo, @data_inicio, @data_fim)

      @gerenciador.estoque = @estoque
      @estoque.veiculos << @veiculo
      @gerenciador.cadastra_reserva(@reserva)
    end

    context "Quando dado parametros válidos" do
      it "Deve transformar reserva em locação" do
        expect(@gerenciador.reservas.include?(@reserva)).to eq(true)

        locacao = @gerenciador.inicia_locacao(@reserva)

        expect(locacao.class).to eq(Locacao)
        expect(@gerenciador.locacoes.include?(locacao)).to eq(true)
        expect(@gerenciador.reservas.include?(@reserva)).to eq(false)
        expect(@cliente.locacoes.include?(locacao)).to eq(true)
        expect(@veiculo.locacoes.include?(locacao)).to eq(true)
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro caso a reserva não esteja cadastrada" do
        reserva_1 = Reserva.new(@cliente, @veiculo, Date.today - 10, Date.today - 5)

        mensagem_erro = "Reserva não cadastrada"

        expect { @gerenciador.inicia_locacao(reserva_1) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end

  describe "Finaliza locacao" do
    before(:context) do
      @gerenciador = Gerenciador.new
      @estoque = Estoque.new
      @cliente = Cliente.new("11122233300", "Joao Silva")
      @veiculo = Veiculo.new("CAR-1234", "Fiat", "Mobi", 2020, 100)
      @data_inicio = Date.today + 5
      @data_fim = Date.today + 10
      @reserva = Reserva.new(@cliente, @veiculo, @data_inicio, @data_fim)

      @gerenciador.estoque = @estoque
      @estoque.veiculos << @veiculo
      @gerenciador.cadastra_reserva(@reserva)
      @gerenciador.inicia_locacao(@reserva)
    end

    context "Quando dado parametros válidos" do
      it "Deve finalizar uma locação" do
        locacoes = @gerenciador.locacoes
        expect(locacoes[0].cliente.nome).to eq("Joao Silva")

        pagamento = @gerenciador.finaliza_locacao(locacoes[0])

        expect(pagamento.class).to eq(Pagamento)
        expect(pagamento.preco).to eq(500)
        expect(@gerenciador.pagamentos.include?(pagamento)).to eq(true)
        expect(@gerenciador.status.has_key?(@cliente.cpf)).to eq(false)
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro se a locação não tiver sido iniciada" do
        locacao_1 = Locacao.new(@cliente, @veiculo, @data_inicio, @data_fim)

        mensagem_erro = "Locação não inicializada"

        expect { @gerenciador.finaliza_locacao(locacao_1) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end
end

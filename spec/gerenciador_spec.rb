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
end

RSpec.describe Veiculo do
  describe "Initialize" do
    let(:veiculo) { Veiculo.new("CAR-1234", "Fiat", "Mobi", 2020, 100) }

    context "Quando dado parametros válidos" do
      it "Deve inicializar um veículo" do
        expect(veiculo.class).to eq(Veiculo)
        expect(veiculo.placa).to eq("CAR-1234")
        expect(veiculo.fabricante).to eq("Fiat")
        expect(veiculo.modelo).to eq("Mobi")
        expect(veiculo.ano).to eq(2020)
        expect(veiculo.diaria_padrao).to eq(100)
        expect(veiculo.diaria_desconto).to eq(90)
        expect(veiculo.reservas).to eq([])
        expect(veiculo.locacoes).to eq([])
      end
    end

    context "Quando parametros inválidos" do
      it "Deve lançar erro quando a placa for inválida" do
        mensagem_erro = "Placa deve conter 3 digitos alfanumericos seguidos de hifen e 4 digitos alfanumericos. Ex: CAR-1234"

        expect { Veiculo.new("CAR1234", "Fiat", "Mobi", 2020, 100) }.to raise_error(ErroValidacao, mensagem_erro)

        expect { Veiculo.new("CAR1-234", "Fiat", "Mobi", 2020, 100) }.to raise_error(ErroValidacao, mensagem_erro)

        expect { Veiculo.new("1234", "Fiat", "Mobi", 2020, 100) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end

  describe "Disponivel" do
    let(:veiculo) { Veiculo.new("CAR-1234", "Fiat", "Mobi", 2020, 100) }
    let(:cliente) { Cliente.new("11122233300", "Joao Silva") }
    let(:veiculo) { Veiculo.new("CAR-1234", "Fiat", "Mobi", 2020, 100) }
    let(:data_inicio) { Date.new(2022, 01, 15) }
    let(:data_fim) { Date.new(2022, 01, 20) }
    let(:reserva) { Reserva.new(cliente, veiculo, data_inicio, data_fim) }
    let(:locacoes) { Locacao.new(cliente, veiculo, data_inicio, data_fim) }

    context "Quando dado parametros validos" do
      it "Deve retornar que veiculo possui dispobilidade nas datas indicadas" do
        veiculo.reservas << reserva
        veiculo.locacoes << reserva
        data_inicio_1 = Date.new(2022, 02, 15)
        data_fim_1 = Date.new(2022, 02, 20)
        data_inicio_2 = Date.new(2022, 01, 12)
        data_fim_2 = Date.new(2022, 01, 14)

        expect(veiculo.disponivel?(data_inicio_1, data_fim_1)).to eq(true)
        expect(veiculo.disponivel?(data_inicio_2, data_fim_2)).to eq(true)
      end

      it "Deve retornar que veiculo NÃO possui dispobilidade nas reservas" do
        veiculo.reservas << reserva
        data_inicio_1 = Date.new(2022, 01, 10)
        data_fim_1 = Date.new(2022, 01, 15)
        data_inicio_2 = Date.new(2022, 01, 20)
        data_fim_2 = Date.new(2022, 01, 30)

        expect(veiculo.disponivel?(data_inicio, data_fim)).to eq(false)
        expect(veiculo.disponivel?(data_inicio_1, data_fim_1)).to eq(false)
        expect(veiculo.disponivel?(data_inicio_2, data_fim_2)).to eq(false)
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro se os parametros não forem datas" do
        mensagem_erro = "Os parâmetros devem ser datas"

        expect { veiculo.disponivel?("2022-01-01", "2022-01-05") }.to raise_error(ErroValidacao, mensagem_erro)
        expect { veiculo.disponivel?(20220101, 20220105) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end
end

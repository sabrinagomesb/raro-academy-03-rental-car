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
        expect(veiculo.disponivel).to eq(true)
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
end

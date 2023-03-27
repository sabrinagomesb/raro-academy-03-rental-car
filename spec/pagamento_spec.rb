RSpec.describe Pagamento do
  describe "Initialize" do
    let(:cliente) { Cliente.new("11122233388", "Daniel Silva") }
    let(:veiculo) { Veiculo.new("CAR-1256", "Hyundai", "HB20", 2020, 120) }
    let(:data_inicio) { Date.new(2022, 02, 15) }
    let(:data_fim) { Date.new(2022, 02, 20) }
    let(:reserva) { Reserva.new(cliente, veiculo, data_inicio, data_fim) }

    let(:pagamento) { Pagamento.new(reserva, reserva.data_fim, reserva.preco) }

    it "Deve inicializar um pagamento" do
      expect(pagamento.class).to eq(Pagamento)
      expect(pagamento.reserva).to eq(reserva)
      expect(pagamento.data).to eq(reserva.data_fim)
      expect(pagamento.valor).to eq(reserva.preco)
    end

    #   context "Quando parametros inválidos" do
    #     it "Deve lançar erro quando a placa for inválida" do
    #       mensagem_erro = "Placa deve conter 3 digitos alfanumericos seguidos de hifen e 4 digitos alfanumericos. Ex: CAR-1234"

    #       expect { Veiculo.new("CAR1234", "Fiat", "Mobi", 2020, 100) }.to raise_error(ErroValidacao, mensagem_erro)

    #       expect { Veiculo.new("CAR1-234", "Fiat", "Mobi", 2020, 100) }.to raise_error(ErroValidacao, mensagem_erro)

    #       expect { Veiculo.new("1234", "Fiat", "Mobi", 2020, 100) }.to raise_error(ErroValidacao, mensagem_erro)
    #     end
    #   end
  end
end

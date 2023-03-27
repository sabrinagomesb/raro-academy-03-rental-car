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
  end
end

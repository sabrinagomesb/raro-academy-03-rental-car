RSpec.describe Pagamento do
  describe "Initialize" do
    let(:cliente) { Cliente.new("11122233388", "Daniel Silva") }
    let(:veiculo) { Veiculo.new("CAR-1256", "Hyundai", "HB20", 2020, 120) }
    let(:data_inicio) { Date.new(2022, 02, 15) }
    let(:data_fim) { Date.new(2022, 02, 20) }
    let(:locacao) { Locacao.new(cliente, veiculo, data_inicio, data_fim) }

    let(:pagamento) { Pagamento.new(locacao, locacao.data_fim, locacao.preco) }

    it "Deve inicializar um pagamento" do
      expect(pagamento.class).to eq(Pagamento)
      expect(pagamento.locacao).to eq(locacao)
      expect(pagamento.data).to eq(locacao.data_fim)
      expect(pagamento.preco).to eq(locacao.preco)
    end
  end
end

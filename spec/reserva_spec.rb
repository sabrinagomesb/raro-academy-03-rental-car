RSpec.describe Reserva do
  describe "Initialize" do
    let(:cliente) { Cliente.new("11122233300", "Joao Silva") }
    let(:veiculo) { Veiculo.new("CAR-1234", "Fiat", "Mobi", 2020, 100) }
    let(:data_inicio) { Date.new(2022, 01, 15) }
    let(:data_fim) { Date.new(2022, 01, 20) }
    let(:reserva) { Reserva.new(cliente, veiculo, data_inicio, data_fim) }

    it "Deve inicializar uma reserva" do
      expect(reserva.class).to eq(Reserva)
      expect(reserva.cliente).to eq(cliente)
      expect(reserva.veiculo).to eq(veiculo)
      expect(reserva.data_inicio).to eq(data_inicio)
      expect(reserva.data_fim).to eq(data_fim)
      expect(reserva.preco).to eq(500)
    end
  end

  describe "Calcula Preço da Reserva" do
    it "Deve calcular preço com diária padrão" do
      cliente1 = Cliente.new("88855522211", "Maria Sousa")
      veiculo1 = Veiculo.new("CAR-4321", "Fiat", "Argo", 2019, 200)
      data_inicio1 = Date.new(2022, 03, 01)
      data_fim1 = Date.new(2022, 03, 03)
      reserva1 = Reserva.new(cliente1, veiculo1, data_inicio1, data_fim1)
      expect(reserva1.calcula_preco).to eq(400)
    end

    it "Deve calcular preço com diária desconto" do
      cliente2 = Cliente.new("88855522200", "Ana Silva")
      veiculo2 = Veiculo.new("CAR-4321", "Fiat", "Argo", 2019, 200)
      data_inicio2 = Date.new(2022, 03, 01)
      data_fim2 = Date.new(2022, 03, 07)
      reserva2 = Reserva.new(cliente2, veiculo2, data_inicio2, data_fim2)
      expect(reserva2.calcula_preco).to eq(1200)
    end
  end
end

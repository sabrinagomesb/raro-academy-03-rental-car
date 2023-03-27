RSpec.describe Locacao do
  let(:cliente) { Cliente.new("11122233300", "Joao Silva") }
  let(:veiculo) { Veiculo.new("CAR-1234", "Fiat", "Mobi", 2020, 100) }
  let(:data_inicio) { Date.new(2022, 01, 15) }
  let(:data_fim) { Date.new(2022, 01, 20) }
  let(:locacao) { Locacao.new(cliente, veiculo, data_inicio, data_fim) }

  it "Deve inicializar uma locação" do
    expect(locacao.class).to eq(Locacao)
    expect(locacao.cliente).to eq(cliente)
    expect(locacao.veiculo).to eq(veiculo)
    expect(locacao.data_inicio).to eq(data_inicio)
    expect(locacao.data_fim).to eq(data_fim)
    expect(locacao.preco).to eq(500)
  end

  it "Deve criar uma instância de Pagamento" do
    # Arrange
    # Act
    pagamento = locacao.realiza_pagamento
    # Assert
    expect(pagamento.class).to eq(Pagamento)
    expect(pagamento.locacao).to eq(locacao)
    expect(pagamento.preco).to eq(locacao.preco)
    expect(pagamento.data).to eq(data_fim)
  end
end

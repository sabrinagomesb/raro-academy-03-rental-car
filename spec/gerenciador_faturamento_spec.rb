RSpec.describe "Gerenciador - Faturamento" do
  describe "Gera faturamento" do
    before(:all) do
      @gerenciador = Gerenciador.new
      @estoque = Estoque.new
      @cliente_1 = Cliente.new("11122233300", "Joao Silva")
      @cliente_2 = Cliente.new("00011122200", "Joao Silva")
      @cliente_3 = Cliente.new("33344455500", "Joao Silva")
      @cliente_4 = Cliente.new("44455566600", "Joao Silva")
      @veiculo_1 = Veiculo.new("CAR-1234", "Fiat", "Mobi", 2020, 100)
      @veiculo_2 = Veiculo.new("ABC-1234", "Fiat", "ARGO", 2022, 200)
      @data_inicio = Date.today + 5
      @data_fim = Date.today + 10
      @reserva_1 = Reserva.new(@cliente_1, @veiculo_1, Date.today + 10, Date.today + 18)
      @reserva_2 = Reserva.new(@cliente_2, @veiculo_2, Date.today + 6, Date.today + 8)
      @reserva_3 = Reserva.new(@cliente_3, @veiculo_1, Date.today + 40, Date.today + 50)
      @reserva_4 = Reserva.new(@cliente_4, @veiculo_2, Date.today + 200, Date.today + 205)

      @gerenciador.estoque = @estoque
      @estoque.veiculos << @veiculo_1
      @gerenciador.cadastra_reserva(@reserva_1)
      @gerenciador.cadastra_reserva(@reserva_2)
      @gerenciador.cadastra_reserva(@reserva_3)
      @gerenciador.cadastra_reserva(@reserva_4)
      @gerenciador.inicia_locacao(@reserva_1)
      @gerenciador.inicia_locacao(@reserva_2)
      @gerenciador.inicia_locacao(@reserva_3)
      @gerenciador.inicia_locacao(@reserva_4)
      @gerenciador.finaliza_locacao(@gerenciador.locacoes[0])
      @gerenciador.finaliza_locacao(@gerenciador.locacoes[1])
      @gerenciador.finaliza_locacao(@gerenciador.locacoes[2])
      @gerenciador.finaliza_locacao(@gerenciador.locacoes[3])
    end

    it "Deve gerar faturamento mensal" do
      faturamento = { 2023 => { 4 => 4080.0, 5 => 1800.0, 10 => 1000.0 } }

      expect(@gerenciador.faturamento).to eq(faturamento)
      expect(@gerenciador.faturamento.has_key?((Date.today + 10).year)).to eq(true)
    end
  end
end

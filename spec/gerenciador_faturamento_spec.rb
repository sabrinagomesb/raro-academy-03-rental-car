RSpec.describe "Gerenciador - Faturamento" do
  describe "Gera faturamento" do
    before(:all) do
      @gerenciador = Gerenciador.new
      @estoque = Estoque.new
      @cliente_1 = Cliente.new("11122233300", "Maria Santos")
      @cliente_2 = Cliente.new("00011122200", "Joao Silva")
      @cliente_3 = Cliente.new("33344455500", "Jose Sousa")
      @cliente_4 = Cliente.new("44455566600", "Josefa Silva")
      @cliente_5 = Cliente.new("44455566611", "Pedro Santos")
      @veiculo_1 = Veiculo.new("CAR-1234", "Fiat", "Mobi", 2020, 100)
      @veiculo_2 = Veiculo.new("ABC-1234", "Fiat", "ARGO", 2022, 200)
      @veiculo_3 = Veiculo.new("RAR-1234", "Hyundai", "HB20", 2018, 250)
      @data_inicio = Date.today + 5
      @data_fim = Date.today + 10
      @reserva_1 = Reserva.new(@cliente_1, @veiculo_1, Date.today + 10, Date.today + 18)
      @reserva_2 = Reserva.new(@cliente_2, @veiculo_2, Date.today + 6, Date.today + 8)
      @reserva_3 = Reserva.new(@cliente_3, @veiculo_1, Date.today + 40, Date.today + 50)
      @reserva_4 = Reserva.new(@cliente_4, @veiculo_2, Date.today + 200, Date.today + 205)
      @reserva_5 = Reserva.new(@cliente_5, @veiculo_3, Date.today + 400, Date.today + 405)

      @gerenciador.estoque = @estoque
      @estoque.veiculos << @veiculo_1 << @veiculo_2 << @veiculo_3
      @gerenciador.cadastra_reserva(@reserva_1)
      @gerenciador.cadastra_reserva(@reserva_2)
      @gerenciador.cadastra_reserva(@reserva_3)
      @gerenciador.cadastra_reserva(@reserva_4)
      @gerenciador.cadastra_reserva(@reserva_5)
      @gerenciador.inicia_locacao(@reserva_1)
      @gerenciador.inicia_locacao(@reserva_2)
      @gerenciador.inicia_locacao(@reserva_3)
      @gerenciador.inicia_locacao(@reserva_4)
      @gerenciador.inicia_locacao(@reserva_5)
      @gerenciador.finaliza_locacao(@gerenciador.locacoes[0])
      @gerenciador.finaliza_locacao(@gerenciador.locacoes[1])
      @gerenciador.finaliza_locacao(@gerenciador.locacoes[2])
      @gerenciador.finaliza_locacao(@gerenciador.locacoes[3])
      @gerenciador.finaliza_locacao(@gerenciador.locacoes[4])
    end

    it "Deve gerar faturamento mensal" do
      faturamento = { 2023 => { 4 => 5200.0, 5 => 2700.0, 10 => 2000.0 }, 2024 => { 5 => 1250.0 } }

      expect(@gerenciador.faturamento).to eq(faturamento)
      expect(@gerenciador.faturamento.has_key?((Date.today + 10).year)).to eq(true)
    end

    it "Deve imprimir faturamento" do
      tabela = "|------|-----|-------------------|\n| Ano  | Mes |    Valor Total    |\n|------|-----|-------------------|\n| 2023 | 4   | R$ 5.200,00       |\n| 2023 | 5   | R$ 2.700,00       |\n| 2023 | 10  | R$ 2.000,00       |\n| 2024 | 5   | R$ 1.250,00       |\n|------|-----|-------------------|\n"

      expect(@gerenciador.imprime_faturamento).to eq(tabela)
    end
  end
end

RSpec.describe "Gerenciador - Ranking" do
  describe "Gera ranking de veículos mais queridos" do
    before(:each) do
      @estoque = Estoque.new
      @gerenciador = Gerenciador.new
      @gerenciador.estoque = @estoque

      @veiculo_1 = Veiculo.new("RAR-1234", "Fiat", "Mobi", 2021, 100)
      @veiculo_2 = Veiculo.new("ABC-4444", "Fiat", "Argo", 2022, 300)
      @veiculo_3 = Veiculo.new("FOR-7799", "Hyundai", "HB20", 2019, 200)
      @veiculo_4 = Veiculo.new("BUS-1234", "Toyota", "Corolla", 2023, 400)

      @estoque.cadastra_veiculo(@veiculo_1)
      @estoque.cadastra_veiculo(@veiculo_2)
      @estoque.cadastra_veiculo(@veiculo_3)
      @estoque.cadastra_veiculo(@veiculo_4)

      @cliente_1 = Cliente.new("11122233300", "Joao Silva")
      @cliente_2 = Cliente.new("22233344411", "Maria Silva")
      @cliente_3 = Cliente.new("33344455522", "Jose Pereira")
      @cliente_4 = Cliente.new("44455566633", "Ana Maria")
      @cliente_5 = Cliente.new("55566677744", "Pedro Carlos")
      @cliente_6 = Cliente.new("66677788855", "Paulo José")

      @gerenciador.cadastra_cliente(@cliente_1)
      @gerenciador.cadastra_cliente(@cliente_2)
      @gerenciador.cadastra_cliente(@cliente_3)
      @gerenciador.cadastra_cliente(@cliente_4)
      @gerenciador.cadastra_cliente(@cliente_5)
      @gerenciador.cadastra_cliente(@cliente_6)

      @reserva_1 = Reserva.new(@cliente_1, @veiculo_1, Date.today + 10, Date.today + 18)
      @reserva_2 = Reserva.new(@cliente_2, @veiculo_1, Date.today + 20, Date.today + 28)
      @reserva_3 = Reserva.new(@cliente_3, @veiculo_1, Date.today + 30, Date.today + 38)
      @reserva_4 = Reserva.new(@cliente_4, @veiculo_2, Date.today + 40, Date.today + 48)
      @reserva_5 = Reserva.new(@cliente_5, @veiculo_3, Date.today + 50, Date.today + 58)
      @reserva_6 = Reserva.new(@cliente_6, @veiculo_3, Date.today + 60, Date.today + 68)

      @gerenciador.cadastra_reserva(@reserva_1)
      @gerenciador.cadastra_reserva(@reserva_2)
      @gerenciador.cadastra_reserva(@reserva_3)
      @gerenciador.cadastra_reserva(@reserva_4)
      @gerenciador.cadastra_reserva(@reserva_5)
      @gerenciador.cadastra_reserva(@reserva_6)

      @gerenciador.inicia_locacao(@reserva_1)
      @gerenciador.inicia_locacao(@reserva_3)
      @gerenciador.inicia_locacao(@reserva_4)
      @gerenciador.inicia_locacao(@reserva_5)

      @gerenciador.finaliza_locacao(@gerenciador.locacoes[0])
      @gerenciador.finaliza_locacao(@gerenciador.locacoes[1])
      @gerenciador.finaliza_locacao(@gerenciador.locacoes[2])
    end

    it "Deve gerar e atualizar ranking" do
      expect(@gerenciador.ranking[@veiculo_1]).to eq(3)
      expect(@gerenciador.ranking[@veiculo_2]).to eq(1)
      expect(@gerenciador.ranking[@veiculo_3]).to eq(2)
      expect(@gerenciador.ranking[@veiculo_4]).to eq(0)
    end

    it "Deve imprimir a tabela de ranking" do
      tabela = "|-----------------------------------------------------------------------------------|\n|                                MODELOS MAIS QUERIDOS                              |\n|-----------------------------------------------------------------------------------|\n|  #  | Fabricante           | Modelo          | Ano  | Reservas | Locações | Total |\n|-----|----------------------|-----------------|------|----------|----------|-------|\n|  3  | Fiat                 | Mobi            | 2021 | 1        | 2        | 3     |\n|  2  | Hyundai              | HB20            | 2019 | 1        | 1        | 2     |\n|  1  | Fiat                 | Argo            | 2022 | 0        | 1        | 1     |\n|-----|----------------------|-----------------|------|----------|----------|-------|\n"

      expect { @gerenciador.imprime_ranking }.to output(tabela).to_stdout
    end
  end
end

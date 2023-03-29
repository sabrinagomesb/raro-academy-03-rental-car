RSpec.describe Estoque do
  describe "Cadastra veiculo" do
    let(:estoque) { Estoque.new }

    context "Quando dado parametros válidos" do
      it "Deve adicionar veiculo ao estoque" do
        veiculo = Veiculo.new("RAR-1234", "Fiat", "Mobi", 2021, 100)
        estoque.cadastra_veiculo(veiculo)

        expect(estoque.veiculos.include?(veiculo)).to eq(true)
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro caso o parametro não seja um veiculo" do
        mensagem_erro = "O parametro informado não é um veículo"
        expect { estoque.cadastra_veiculo("teste") }.to raise_error(ErroValidacao, mensagem_erro)
      end

      it "Deve lançar erro se o veículo já estiver cadastrado" do
        veiculo = Veiculo.new("RAR-1256", "Fiat", "Mobi", 2021, 100)
        estoque.cadastra_veiculo(veiculo)
        expect(estoque.veiculos.include?(veiculo)).to eq(true)

        mensagem_erro = "Veiculo já está cadastrado"
        expect { estoque.cadastra_veiculo(veiculo) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end

  describe "Atualiza preços do veiculo" do
    let(:estoque) { Estoque.new }

    context "Quando dado parametros válidos" do
      it "Deve atualizar preços do veiculo" do
        veiculo = Veiculo.new("RAR-1234", "Fiat", "Mobi", 2021, 100)
        estoque.cadastra_veiculo(veiculo)
        expect(estoque.veiculos.include?(veiculo)).to eq(true)

        estoque.atualiza_diaria_veiculo(veiculo, 200)
        expect(veiculo.diaria_padrao).to eq(200)
        expect(veiculo.diaria_desconto).to eq(180)
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro se o veículo não existir no estoque" do
        veiculo = Veiculo.new("RAR-1234", "Fiat", "Mobi", 2021, 100)

        mensagem_erro = "Veículo informado não existe no estoque."
        expect(estoque.veiculos.include?(veiculo)).to eq(false)
        expect { estoque.atualiza_diaria_veiculo(veiculo, 200) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end

  describe "Remove veiculo" do
    let(:estoque) { Estoque.new }
    let(:cliente) { Cliente.new("11122233300", "Joao Silva") }
    let(:veiculo) { Veiculo.new("CAR-1234", "Fiat", "Mobi", 2020, 100) }
    let(:data_inicio) { Date.new(2022, 01, 15) }
    let(:data_fim) { Date.new(2022, 01, 20) }
    let(:reserva) { Reserva.new(cliente, veiculo, data_inicio, data_fim) }

    context "Quando dado parametros válidos" do
      it "Deve remover veiculo do estoque" do
        estoque.cadastra_veiculo(veiculo)
        expect(estoque.veiculos.include?(veiculo)).to eq(true)

        estoque.remove_veiculo(veiculo)
        expect(estoque.veiculos.include?(veiculo)).to eq(false)
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro se o veículo estiver em locação" do
        veiculo = Veiculo.new("RAR-1256", "Fiat", "Mobi", 2021, 100)
        cliente = Cliente.new("11122233300", "Joao Silva")
        data_inicio = Date.new(2022, 01, 15)
        data_fim = Date.new(2022, 01, 20)
        reserva = Reserva.new(cliente, veiculo, data_inicio, data_fim)

        veiculo.reservas << reserva
        estoque.cadastra_veiculo(veiculo)
        expect(estoque.veiculos.include?(veiculo)).to eq(true)

        mensagem_erro = "Veículo não está disponível no estoque, por isso não pode ser removido"

        expect { estoque.remove_veiculo(veiculo) }.to raise_error(ErroValidacao, mensagem_erro)
      end

      it "Deve lançar erro se o veículo não existir no estoque" do
        veiculo = Veiculo.new("RAR-1256", "Fiat", "Mobi", 2021, 100)
        estoque.cadastra_veiculo(veiculo)
        expect(estoque.veiculos.include?(veiculo)).to eq(true)
        estoque.remove_veiculo(veiculo)
        expect(estoque.veiculos.include?(veiculo)).to eq(false)

        mensagem_erro = "Veículo informado não existe no estoque."
        expect { estoque.remove_veiculo(veiculo) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end

  describe "Veiculos disponiveis" do
    let(:estoque) { Estoque.new }
    let(:cliente) { Cliente.new("11122233300", "Joao Silva") }
    let(:veiculo) { Veiculo.new("BUS-1234", "Fiat", "Uno", 2015, 50) }
    let(:data_inicio) { Date.new(2022, 01, 01) }
    let(:data_fim) { Date.new(2022, 01, 05) }
    let(:reserva) { Reserva.new(cliente, veiculo, data_inicio, data_fim) }
    # let(:locacao) { Locacao.new(cliente, veiculo, data_inicio, data_fim) }

    context "Quando dado parametros válidos" do
      it "Deve retornar lista de veiculos disponíveis" do
        veiculo_1 = Veiculo.new("RAR-1234", "Fiat", "Mobi", 2021, 100)
        veiculo_2 = Veiculo.new("ABC-4444", "Fiat", "Argo", 2022, 300)
        estoque.cadastra_veiculo(veiculo)
        estoque.cadastra_veiculo(veiculo_1)
        estoque.cadastra_veiculo(veiculo_2)

        veiculo.reservas << reserva

        veiculos = estoque.veiculos_disponiveis(data_inicio, data_fim)

        expect(veiculos.include?(veiculo)).to eq(false)
        expect(veiculos.include?(veiculo_1)).to eq(true)
        expect(veiculos.include?(veiculo_2)).to eq(true)
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro se os parametros não forem datas" do
        mensagem_erro = "Os parâmetros devem ser datas"

        expect { estoque.veiculos_disponiveis("2022-01-01", "2022-01-05") }.to raise_error(ErroValidacao, mensagem_erro)
        expect { estoque.veiculos_disponiveis(20220101, 20220105) }.to raise_error(ErroValidacao, mensagem_erro)
      end
    end
  end

  describe "Gera preços" do
    let(:estoque) { Estoque.new }

    it "Deve gerar e atualizar tabela de preços" do
      veiculo_1 = Veiculo.new("RAR-1234", "Fiat", "Mobi", 2021, 100)
      estoque.cadastra_veiculo(veiculo_1)

      precos = Hash.new { |hash, key| hash[key] = Hash.new { |hash, key| hash[key] = 0 } }

      precos[veiculo_1.placa][:diaria_padrao] = veiculo_1.diaria_padrao
      precos[veiculo_1.placa][:diaria_desconto] = veiculo_1.diaria_desconto

      expect(estoque.precos).to eq(precos)
    end
  end
end

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

  describe "Remove veiculo" do
    let(:estoque) { Estoque.new }
    context "Quando dado parametros válidos" do
      it "Deve remover veiculo do estoque" do
        veiculo = Veiculo.new("RAR-1234", "Fiat", "Mobi", 2021, 100)
        estoque.cadastra_veiculo(veiculo)
        expect(estoque.veiculos.include?(veiculo)).to eq(true)

        estoque.remove_veiculo(veiculo)
        expect(estoque.veiculos.include?(veiculo)).to eq(false)
      end
    end

    context "Quando dado parametros inválidos" do
      it "Deve lançar erro se o veículo estiver em locação" do
        #arrange
        veiculo = Veiculo.new("RAR-1256", "Fiat", "Mobi", 2021, 100)
        veiculo.disponivel = false
        estoque.cadastra_veiculo(veiculo)
        expect(estoque.veiculos.include?(veiculo)).to eq(true)

        mensagem_erro = "Veículo não está disponível no estoque, por isso não pode ser removido"

        expect { estoque.remove_veiculo(veiculo) }.to raise_error(ErroValidacao, mensagem_erro)
      end

      it "Deve lançar erro se o veículo não existir no estoque" do
        #arrage
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
end

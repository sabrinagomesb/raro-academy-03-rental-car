RSpec.describe "Formata valor para real" do
  it "Deve retornar o valor em reais" do
    expect(UtilsFormat.formata_em_real(50)).to eq("R$ 50,00")
    expect(UtilsFormat.formata_em_real(5000)).to eq("R$ 5.000,00")
    expect(UtilsFormat.formata_em_real(450)).to eq("R$ 450,00")
    expect(UtilsFormat.formata_em_real(123456.78)).to eq("R$ 123.456,78")
    expect(UtilsFormat.formata_em_real(123456.78).class).to eq(String)
  end
end

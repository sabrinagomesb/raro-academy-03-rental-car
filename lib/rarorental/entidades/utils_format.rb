class UtilsFormat
  def self.formata_em_real(valor)
    "R$ #{"%.2f" % valor}".gsub(".", ",").reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse
  end
end

# frozen_string_literal: true
require "byebug"
require "date"
require_relative "rarorental/version"

require_relative "./rarorental/entidades/cliente"
require_relative "./rarorental/entidades/estoque"
require_relative "./rarorental/entidades/gerenciador"
require_relative "./rarorental/entidades/locacao"
require_relative "./rarorental/entidades/reserva"
require_relative "./rarorental/entidades/pagamento"
require_relative "./rarorental/entidades/veiculo"
require_relative "./rarorental/entidades/utils_format"
require_relative "./rarorental/errors/erro_validacao"

module Rarorental
  class Error < StandardError; end

  # Your code goes here...
end

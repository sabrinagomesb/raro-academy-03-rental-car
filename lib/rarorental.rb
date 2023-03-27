# frozen_string_literal: true

require_relative "rarorental/version"

require_relative "./rarorental/entidades/cliente"
require_relative "./rarorental/entidades/reserva"
require_relative "./rarorental/entidades/veiculo"
require_relative "./rarorental/errors/erro_validacao"

module Rarorental
  class Error < StandardError; end

  # Your code goes here...
end

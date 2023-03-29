# Testes

## Cliente

- Initialize
  - Quando dado parametros válidos
    - Deve inicializar um cliente
  - Quando dado parametros inválidos
    - Deve lançar erro quando nome for vazio ou nulo
    - Deve lançar erro quando cpf não tiver 11 caracteres numéricos
- Atualiza cadastro
  - Quando dado parametros válidos
    - Deve alterar o nome
  - Quando dado parametros inválidos
    - Deve lançar erro quando nome for vazio ou nulo

## Estoque

- Cadastra veiculo
  - Quando dado parametros válidos
    - Deve adicionar veiculo ao estoque
  - Quando dado parametros inválidos
    - Deve lançar erro caso o parametro não seja um veiculo
    - Deve lançar erro se o veículo já estiver cadastrado
- Atualiza preços do veiculo
  - Quando dado parametros válidos
    - Deve atualizar preços do veiculo
  - Quando dado parametros inválidos
    - Deve lançar erro se o veículo não existir no estoque
- Remove veiculo
  - Quando dado parametros válidos
    - Deve remover veiculo do estoque
  - Quando dado parametros inválidos
    - Deve lançar erro se o veículo estiver em locação
    - Deve lançar erro se o veículo não existir no estoque
- Veiculos disponiveis
  - Quando dado parametros válidos
    - Deve retornar lista de veiculos disponíveis
  - Quando dado parametros inválidos
    - Deve lançar erro se os parametros não forem datas
- Gera tabela de preços
  - Deve gerar e atualizar tabela de preços
  - Deve imprimir a tabela com os preços

## Gerenciador

### Gerenciador - Cliente

- Cadastra cliente
  - Quando dado parametros válidos
    - Deve adicionar cliente na lista de Clientes
  - Quando dado parametros inválidos
    - Deve lançar erro caso o parametro não seja um Cliente
    - Deve lançar erro se o cliente já estiver cadastrado
- Atualiza cliente
  - - Quando dado parametros válidos
    - Deve atualizar nome do cliente
  - - Quando dado parametros inválidos
    - Deve lançar erro se o cliente não estiver cadastrado
- Remove cliente
  - - Quando dado parametros válidos
    - Deve remover cliente da lista de Clientes
  - Quando dado parametros inválidos
    - Deve lançar erro se o cliente já estiver realizado uma reserva
    - Deve lançar erro se o cliente já estiver realizado uma locação
    - Deve lançar erro se o cliente não estiver na lista de clientes

### Gerenciador - Faturamento

- Gera faturamento
  - Deve gerar faturamento mensal
  - Deve imprimir faturamento

### Gerenciador - Ranking

- Gera ranking de veículos mais queridos
  - Deve gerar e atualizar ranking
  - Deve ordenar por mais querido - o que possui mais reservas e locações
  - Deve imprimir a tabela de ranking

### Gerenciador - Reservas e Locações

- Cadastra reserva
  - Quando dado parametros válidos
    - Deve cadastrar reserva
  - Quando dado parametros inválidos
    - Deve lançar erro caso o cliente possua reserva/locacao ativa
    - Deve lançar erro se o veiculo estiver indisponível
- Cancela reserva
  - Quando dado parametros válidos
    - Deve cancelar reserva
  - Quando dado parametros inválidos
    - Deve lançar erro se a reserva não estiver cadastrada
    - Deve lançar erro se a reserva estiver fora do prazo de cancelamento
- Inicia locacao
  - Quando dado parametros válidos
    - Deve transformar reserva em locação
  - Quando dado parametros inválidos
    - Deve lançar erro caso a reserva não esteja cadastrada
- Finaliza locacao
  - Quando dado parametros válidos
    - Deve finalizar uma locação
  - Quando dado parametros inválidos
    - Deve lançar erro se a locação não tiver sido iniciada

## Locacao

- Deve inicializar uma locação
- Deve criar uma instância de Pagamento

## Pagamento

- Initialize
  - Deve inicializar um pagamento

## Reserva

- Initialize
  - Deve inicializar uma reserva
- Calcula Preço da Reserva
  - Deve calcular preço com diária padrão
  - Deve calcular preço com diária desconto

## Veiculo

- Initialize
  - Quando dado parametros válidos
    - Deve inicializar um veículo
  - Quando parametros inválidos
    - Deve lançar erro quando a placa for inválida
- Disponivel
  - Quando dado parametros validos
    - Deve retornar que veiculo possui dispobilidade nas datas indicadas
    - Deve retornar que veiculo NÃO possui dispobilidade nas reservas
  - Quando dado parametros inválidos
    - Deve lançar erro se os parametros não forem datas
- Atualiza diarias
  - Deve atualizar os preços das diárias

Finished in 0.04647 seconds (files took 0.31627 seconds to load)
53 examples, 0 failures-

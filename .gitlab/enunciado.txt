# RaroRental

Sua missão é criar um sistema gerenciar uma empresa de locação de veículos.

## Cadastro de Veículos

Para cadastrar um veículo no estoque é necessário informar a placa, o fabricante, o modelo e o ano do veículo.

O sistema deve permitir gerenciar a frota. Ou seja permitir o registro da
aquisição de novos veículos bem como sua retirada do estoque por qualquer motivo.

## Tabela de Preços

Para cada tipo de veículo (fabricante/modelo) é definida uma tabela de preços para o valor da diária para locação até 6 dias e um valor com desconto para locações com mais de 6 dias.

## Clientes

Os clientes são identificados pelo CPF e seu nome completo.
O sistema deve permitir manter um cadastro atualizado de todos os clientes.

## Reservas

Um cliente pode realizar apenas uma reserva simultânea. Um reserva significa que um veiculo será alocado para um determinado cliente em um período.

## Locação

Quando o cliente retira de fato o veículo da loja, a reserva dá origem a locação. A locação termina com a devolução do veículo e sua reentrada no estoque.

## Deve ser possível

- [x] 1 - Deve ser possível adicionar um novo veículo ao estoque.
- [x] 2 - Deve ser possível remover um veículo do estoque.
- [x] 3 - Deve ser possível incluir um novo cliente no sistema.
- [x] 4 - Deve ser possível realizar uma alteração no nome de um cliente já existente.
- [ ] 5 - Deve ser possível buscar quais veículos estarão disponíveis em um determinado período. O resultado da busca deve mostrar o valor que será pago pela reserva respeitando a tabela de preços.
- [x] 6 - Deve ser possível criar uma reserva para um veículo disponível.
- [ ] 7 - Deve ser possível transformar uma locação em reserva.
- [ ] 8 - Deve ser possível finalizar uma locação.
- [ ] 9 - Deve ser possível gerar um relatório mensal com o faturamento da empresa.
- [ ] 10 - Deve ser possível gerar um relatório com a lista de veículos mais queridos pelos clientes.
- [ ] 11 - Deve ser possível alterar a tabela de preços.

## Não deve ser possível

- [x] 1 - Não deve ser possível remover um veículo em locação do estoque.
- [x] 2 - Não deve ser possível remover um cliente da base que já realizou uma reserva ou locação.
- [x] 3 - Não deve ser possível ter mais de uma reserva sobreposta para um mesmo veículo.
- [x] 4 - Não deve ser possível incluir um cliente duplicado na base.
- [ ] 5 - Não deve ser possível incluir um veículo duplicado na base.

## Deve ser garantido

- [ ] 1 - Que se houver alteração no preço da tabela, os relatórios anteriores ao período da alteração não mudem os valores.

## Perguntas e Respostas

- Até quando uma reserva pode ser mantida?

  - Uma reserva pode ser mantida até 24 horas após a data de início da reserva.

- O que é o veículo mais querido?

  - O veículo mais querido é o veículo que foi mais alugado. Que teve mais locações.

- Os dados da tabela serão alimentado quem?

  - Os dados da tabela serão alimentados pelo administrador do sistema.

- O que determina o período de locação?

  - O período de locação é determinado pela data de retirada do veículo e a data de devolução do veículo. Que são as mesmas da reserva.

- Que tipo de dado deve ser usado para guardar a placa?

  - O programador deve escolher o tipo que achar mais adequado.

- É necessário cadastrar os carros em alguma categoria?

  - Não é necessário cadastrar os carros em alguma categoria.

- Qual a data é considerada para o faturamento. A data de retirada ou a data de devolução?

  - A data de devolução.

- Tem limite de dias para a reserva?

  - Não tem limite de dias para a reserva.

- Tera taxa de juros por atraso na devolução do veículo?

  - Não terá taxa de juros por atraso na devolução do veículo.

- É possível criar uma locação sem uma reserva?

  - Não é possível criar uma locação sem uma reserva.

- Como nasce uma locação?

  - Uma locação nasce quando o cliente retira o veículo da loja e deve estar associada a uma reserva.

- É possível ter uma locação ativa e uma reserva futura para uma mesma pessoa?

  - Não é possível ter uma locação ativa e uma reserva futura.

- Uma reserva está associada a uma unidade especifica do veículo?

  - Sim.

- Se houver uma reserva subsequente para o mesmo veículo, e uma locação não for finalizada na data. O que ocorre?

  - A reserva deve ser cancelada.

- O que significa retirar o veículo do estoque?

  - Significa que aquela unidade não estará mais disponível para locação.

- Qual é o período mínimo para uma locação?

  - O período mínimo para uma locação é de 1 dia.

- É possível ter uma locação sem reserva?
  - Não é possível ter uma locação sem reserva.

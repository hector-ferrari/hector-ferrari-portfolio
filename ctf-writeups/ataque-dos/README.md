# Ataque DoS

## O que foi feito
Análise de logs Apache para descobrir o IP com maior volume de requisições.

## Contexto
Desafio da pós-graduação FIAP em Defesa Cibernética (Blue Team).  
O objetivo era identificar o IP que fez mais requisições — possível ataque DoS.

## Desafio proposto
Você nota que existe uma quantidade expressiva de requisições contra seu servidor web, diante da situação, decida analisar os logs do servidor apache `"logs.txt"`. Descubra o IP que mais fez requisição e você poderá utilizá-lo como flag para pontuar.

## Como fiz
1. Extraí os IPs do log.
2. Ordenei e contei as ocorrências por IP.
3. Ordenei o resultado em ordem decrescente para identificar os IPs com mais requisições.

### Comandos utilizados
```bash
awk '{print $1}' logs.txt
sort | uniq -c
sort -nr | head -n 10
```
### Resultado

Identifiquei o IP responsável pelo maior número de requisições.

### Ferramentas usadas

`awk`, `sort`, `uniq`

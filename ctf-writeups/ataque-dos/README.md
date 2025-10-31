# Ataque DoS

## Descrição
Análise de logs Apache para descobrir o IP com maior volume de requisições usando `awk`, `sort` e `uniq`.

## Contexto
Desafio CTF proposto na FIAP para o primeiro challenge da pós-graduação em Defesa Cibernética (Blue Team).  
O objetivo era identificar o IP que realizou mais requisições ao servidor Apache.

## Passos realizados
1. Extração do primeiro campo (IP) de cada linha:
   ```bash
   awk '{print $1}' logs.txt

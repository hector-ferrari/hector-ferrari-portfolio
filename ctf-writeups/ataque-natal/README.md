# Ataque de Natal

## O que foi feito
Análise de logs do servidor HTTP para identificar o malware responsável por requisições suspeitas.

## Contexto
Desafio FIAPLAB — investigar `access_log` para descobrir qual malware estava realizando requisições maliciosas ao servidor.

## Processo de análise
1. Identifiquei o formato das entradas do log (IP, método, URL, User-Agent).  
2. Busquei padrões repetidos e IPs com alta frequência usando `grep`.  
3. Extraí linhas dos IPs suspeitos para análise isolada.  
4. Inspecionei caminhos acessados e User-Agent registrados.  
5. Procurei por termos conhecidos (por exemplo, “jorgee”) e confirmei múltiplas ocorrências.

## Comandos utilizados
```bash
# Procurar linhas com um IP específico
grep 192.10.30.254 access_log > verificandoipjorgee.txt

# Procurar por ocorrência do termo "jorgee" (case-insensitive)
grep -i "jorgee" access_log
```
## Conclusão

As requisições foram atribuídas ao malware identificado como Jorgee, responsável por tentativas de exploração e varredura.

## Ferramentas usadas

grep, análise manual de logs e User-Agent

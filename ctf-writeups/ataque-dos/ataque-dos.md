# Seria um ataque DoS

**Contexto:** Analisar um `logs.txt` de Apache e identificar o IP que realizou mais requisições (flag).

**Passos realizados**
1. Extraí o primeiro campo (IP) de cada linha com `awk '{print $1}'`.
2. Ordenei os IPs e contei frequências com `sort | uniq -c`.
3. Ordenei numericamente decrescente para ver quem mais requisitou.

**Comandos**
```bash
awk '{print $1}' logs.txt | sort | uniq -c | sort -nr | head -n 10

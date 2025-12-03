# 🛡️ Relatório SOC L1 – Firewall Alert

**Tipo:** Tráfego suspeito bloqueado  
**Classificação:** Baixa  
**Status:** Contido  
**Detecção:** 11/10/2025  
**Analista:** Hector Ferrari  

---

## 1. Resumo
Firewall detectou e bloqueou tentativa de varredura de portas externas contra o servidor web corporativo.

---

## 2. Evidências
- IP origem: 201.17.33.99  
- Destino: servidor Web (10.0.15.7)  
- Portas: 80, 443, 8080, 22, 3306  
- Evento: 48 conexões rejeitadas em 1 minuto  
- Assinatura: Port Scan / Reconnaissance

---

## 3. Análise
Trata-se de um scan automatizado comum na internet.  
Nenhuma exploração tentada após o scan.

---

## 4. Ações Tomadas (L1)
- Validação do alerta  
- Checagem de tentativas posteriores → nenhuma  
- Adição do IP à lista de bloqueio temporário  
- Registro do incidente para referência

---

## 5. Conclusão
**Falso positivo benigno.**  
Scan comum de internet, porém devidamente bloqueado pelo firewall.

---

## 6. Recomendações
- Manter regras de firewall e IDS atualizadas  
- Implementar rate-limiting adicional  

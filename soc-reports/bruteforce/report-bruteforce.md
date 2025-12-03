# 🛡️ Relatório SOC L1 – Brute Force

**Tipo:** Tentativas repetidas de login  
**Classificação:** Média  
**Status:** Contido  
**Detecção:** 03/12/2025  
**Analista:** Hector Ferrari

---

## 1. Resumo
O SIEM gerou alerta de múltiplas tentativas de login falhas contra a conta *admin* via SSH.

---

## 2. Evidências
- IP de origem: 185.23.91.14  
- Logs: 54 tentativas em 3 minutos  
- User-agent: SSH-2.0libssh-0.8.90  

---

## 3. Análise
O padrão é consistente com ataque de brute force automatizado.  
Nenhuma tentativa bem-sucedida.

---

## 4. Ações Tomadas
- Validação do alerta  
- Consulta do IP em AbuseIPDB (malicioso)  
- Firewall: bloqueio aplicado  
- Confirmação de que não houve login bem-sucedido  

---

## 5. Conclusão
**Verdadeiro positivo.** Ataque automatizado bloqueado com sucesso.

---

## 6. Recomendações
- Reforçar política de SSH  
- Habilitar MFA para usuários administrativos  

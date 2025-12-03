# 🛡️ Relatório SOC L1 – Acesso Suspeito

**Tipo:** Login suspeito fora do padrão  
**Classificação:** Média  
**Status:** Contido  
**Detecção:** 20/10/2025  
**Analista:** Hector Ferrari  

---

## 1. Resumo
Alerta gerado por tentativa de login bem-sucedido na conta de um usuário corporativo a partir de um país incomum.

---

## 2. Evidências
- Usuário: marcos.silva  
- IP origem: 91.204.12.77  
- Localização: Ucrânia  
- Últimos logins do usuário: Brasil  
- Device ID: não reconhecido  
- Horário: 03:41 AM (fora do horário normal do usuário)

---

## 3. Análise
O usuário afirmou não ter viajado e desconhece o acesso.  
Caracteriza possível comprometimento de credenciais.

---

## 4. Ações Tomadas (L1)
- Checagem de logins passados → padrão inconsistente  
- Reset imediato da senha do usuário  
- Terminação de sessões ativas  
- Revisão de logs de atividade pós-login → nenhuma execução suspeita  
- Recomendação ao L2 para investigação profunda

---

## 5. Conclusão
**Verdadeiro positivo.** Forte indicação de credenciais comprometidas.

---

## 6. Recomendações
- Habilitar MFA obrigatório para todos  
- Avaliar política de senha  

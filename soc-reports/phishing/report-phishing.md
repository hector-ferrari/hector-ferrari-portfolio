# 🛡️ Relatório SOC L1 – Phishing

**Tipo:** E-mail suspeito (phishing)  
**Classificação:** Alta  
**Status:** Encaminhado para L2  
**Detecção:** 03/12/2025  
**Analista:** Hector Ferrari  

---

## 1. Resumo
Alerta do sistema de e-mail identificou uma mensagem suspeita contendo link malicioso e remetente não verificado. O e-mail foi marcado como possível tentativa de phishing direcionado.

---

## 2. Evidências
- Remetente: "Suporte Microsoft" <support@m1crosoft-security.com>  
- Domínio: criado há 5 dias (Whois)  
- Assunto: "Atualização urgente da sua conta"  
- Link: `https://security-verification-login.com/office365`  
- Análise do cabeçalho: SMTP via servidor fora do país, sem DKIM ou SPF válidos

---

## 3. Análise
O domínio e o link direcionam para uma página fake do Microsoft 365 com formulário de coleta de credenciais.  
O cabeçalho confirma spoofing: domínio não autorizado enviando em nome da Microsoft.

---

## 4. Ações Tomadas (L1)
- Validação do alerta pelo SIEM  
- Verificação de reputação do link → **malicioso**  
- Isolamento do e-mail para análise  
- Bloqueio do domínio no gateway de e-mail  
- Notificação ao L2 para análise adicional

---

## 5. Conclusão
**Verdadeiro positivo.** Tentativa de phishing direcionado com intenção de roubo de credenciais.

---

## 6. Recomendações
- Habilitar políticas mais rígidas de SPF/DKIM/DMARC  
- Reforçar campanhas internas de conscientização  

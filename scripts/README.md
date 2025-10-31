# Gerenciador de Samba (script-menu-samba.sh)

Script em Bash para gerenciamento manual e seguro do serviço Samba e das regras do firewall UFW.  
Principais funções:
- Iniciar e parar serviços `smbd` e `nmbd`
- Liberar e revogar portas no UFW
- Exibir status e realizar teste de configuração (`testparm`)

Recomendação: ao usar em produção, revise permissões e adapte o perfil do UFW conforme seu ambiente.

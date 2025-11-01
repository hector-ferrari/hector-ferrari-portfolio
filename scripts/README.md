# Gerenciador de Samba — `script-menu-samba.sh`

## O que foi feito
Criação de um script em Bash para gerenciar o Samba de forma manual e segura. O script permite iniciar e parar os serviços `smbd` e `nmbd`, ativar e revogar portas no firewall UFW, exibir status dos serviços e realizar teste de configuração (`testparm`). 
O objetivo é evitar problemas comuns ao iniciar o Samba, especialmente em ambientes com máquinas virtuais e redes variáveis, e garantir a segurança do sistema.

## Contexto
Durante meu período na FATEC Osasco, utilizava frequentemente o Samba para compartilhar arquivos entre máquinas Windows e Linux nos laboratórios. O serviço do Samba apresentava erros ao iniciar, principalmente quando a rede mudava, o que dificultava o uso em VMs. 
Para contornar esses problemas e aplicar boas práticas de segurança, desenvolvi este script que desativa o início automático do Samba, controla portas via firewall e permite ativação/desativação segura do serviço. Isso também evita exposição a vulnerabilidades conhecidas.

## Desafio proposto
Utilizando o script, execute as seguintes tarefas de forma segura:
- Ativar o Samba com os serviços `smbd` e `nmbd` em execução e firewall configurado;
- Verificar status completo do Samba e do firewall;
- Testar a configuração com `testparm` e obter informações de IP;
- Desativar o Samba e remover as regras do firewall após o uso.

## Processo de uso
1. Execute o script:
```bash
./script-menu-samba.sh
```
2. No menu interativo, escolha a opção desejada:
   - **1**: Exibir status completo do Samba e UFW
   - **2**: Ativar Samba (serviços + firewall)
   - **3**: Iniciar apenas o serviço `smbd`
   - **4**: Exibir IP da interface
   - **5**: Testar configuração com `testparm`
   - **6**: Desativar Samba e remover regras do firewall
   - **0**: Sair do script
3. Pressione Enter após cada ação para retornar ao menu.

## Comandos utilizados
O script utiliza os seguintes comandos principais:
- `systemctl` — para iniciar, parar e verificar status dos serviços `smbd` e `nmbd`
- `ufw` — para ativar ou revogar regras de firewall
- `testparm` — para testar a configuração do Samba
- `ip` — para exibir informações de endereço IP da interface

## Conclusão / Notas finais
Este script demonstra habilidades práticas em Bash, administração de serviços Linux e configuração de firewall, além de aplicação de boas práticas de segurança em ambiente de laboratório. 

---
**Observação:** Sempre desative o Samba e remova regras do firewall quando não estiver em uso para garantir segurança da rede.

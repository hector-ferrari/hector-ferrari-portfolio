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

## Código (coloque este arquivo em `scripts/script-menu-samba.sh`)
Salve o conteúdo abaixo como `script-menu-samba.sh` e dê permissão de execução (`chmod +x script-menu-samba.sh`):

```bash
#!/bin/bash

# Menu While > Programa de informações do SAMBA orientado por menus:
# Este script gerencia o serviço do Samba de forma manual para maior segurança.
# Ele também gerencia as regras do UFW para abrir e fechar as portas do Samba.

# Boas Práticas de Segurança:
#   - DESATIVE o início automático do Samba no boot para garantir que ele
#     não inicie por conta própria:
#     $ sudo systemctl disable smbd.service nmbd.service
#   - Ative o Samba apenas quando estiver em uma rede segura e precisar
#     compartilhar arquivos.
#   - Use a opção '6' para desativar o Samba e fechar as portas do firewall
#     quando terminar, especialmente em redes não confiáveis.
# ====================================================================

# Perfil do UFW a ser usado (ajuste conforme seu ambiente):
UFW_PROFILE="Samba"

# Nome dos serviços do Samba 
SAMBA_SERVICE_SMBD="smbd.service"
SAMBA_SERVICE_NMBD="nmbd.service"

#############################
while true; do
    clear
    cat << EOF
 ==============================================
             GERENCIADOR DO SAMBA
 ==============================================
 Selecione a opção desejada:
    1. Exibir status completo do Samba
    2. Ativar Samba para Compartilhar
    3. Iniciar serviço do Samba (somente)
    4. Exibir IP
    5. Realizar >>> Testparm
    6. Desativar Samba e Firewall
    0. Sair
EOF
    read -p "Selecione a Opção [0-6] > " REPLY
    case "$REPLY" in

    0)
        break
        ;;

    1)
        echo "Exibindo status dos serviços do Samba e UFW: "
        echo "-----------------------------------------"
        systemctl --no-pager status "$SAMBA_SERVICE_SMBD"
        echo "-----------------------------------------"
        systemctl --no-pager status "$SAMBA_SERVICE_NMBD"
        echo "-----------------------------------------"
        sudo ufw status | grep "$UFW_PROFILE" || true
        read -p "Pressione [Enter] para continuar"
        sleep 2
        ;;

    2)
        echo "Ativando Samba para Compartilhar (iniciar serviços + Firewall):"
        systemctl start "$SAMBA_SERVICE_SMBD"
        systemctl start "$SAMBA_SERVICE_NMBD"
        # Tenta habilitar um profile se existir, caso contrário libera portas padrão do Samba
        if ufw app list | grep -q "^$UFW_PROFILE"; then
            ufw allow "$UFW_PROFILE"
        else
            ufw allow 137,138/udp
            ufw allow 139/tcp
            ufw allow 445/tcp
        fi
        sleep 2
        echo "Samba Ativado."
        read -p "Pressione [Enter] para continuar"
        ;;

    3)
        echo "Iniciando serviço de Compartilhamento local (apenas SMBD): "
        echo "Esta opção não ajusta o firewall." 
        systemctl start "$SAMBA_SERVICE_SMBD"
        sleep 2
        echo "Serviço SMBD iniciado"
        read -p "Pressione [Enter] para continuar" 
        ;;

    4)
        echo "Abrindo Informações específicas de IP: "
        # Ajuste a interface conforme necessário (ex.: eth0, enp0s3, etc.)
        ip -4 addr show dev eth1 2>/dev/null || ip -4 addr show
        sleep 4
        ;;

    5)
        echo "Realizando TESTPARM"
        sleep 2
        testparm
        echo "Teste realizado" 
        read -p "Pressione [Enter] para continuar"
        ;;

    6)
        echo "Desativando Samba e Firewall..."
        systemctl stop "$SAMBA_SERVICE_SMBD"
        systemctl stop "$SAMBA_SERVICE_NMBD"
        # Remove regras do UFW de forma segura
        if ufw app list | grep -q "^$UFW_PROFILE"; then
            ufw delete allow "$UFW_PROFILE" || true
        else
            ufw delete allow 137,138/udp || true
            ufw delete allow 139/tcp || true
            ufw delete allow 445/tcp || true
        fi
        sleep 2
        echo "Samba desativado."
        read -p "Pressione [Enter] para continuar"
        ;;

    *)
        echo "Número inválido, tente novamente."
        ;;
    esac
    sleep  1

done
echo "Encerrado com sucesso, obrigado!"
```

## Processo de uso (resumido)
1. Desative o início automático do Samba no boot (opcional, recomendado):
```bash
sudo systemctl disable smbd.service nmbd.service
```
2. Ajuste a variável `UFW_PROFILE` no topo do script se necessário (ou crie um perfil UFW chamado `Samba`).
3. Torne o script executável:
```bash
chmod +x script-menu-samba.sh
```
4. Execute e use o menu para gerenciar o Samba de forma segura.

## Comandos utilizados
- `systemctl` — gerência de serviços
- `ufw` — controle de firewall
- `testparm` — verificação de configuração do Samba
- `ip` — informações de endereços de rede

## Notas para recrutadores (opcional)
- Projeto mostra experiência prática com administração Linux, Bash scripting e segurança básica de rede.
- Código organizado e comentado; pronto para demonstração em entrevista técnica.

---
**Observação:** Sempre desative o Samba e remova regras do firewall quando não estiver em uso para garantir segurança da rede.

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

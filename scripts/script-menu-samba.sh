#!/bin/bash

#Menu While > Programa de informações do SAMBA orientado por menus:
#Este script gerencia o serviço o serviço do Samba de forma manual para maior segurança.
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
        5. Realizar >>> Testeparm
	6. Desativar Samba e Firewall
	0. Sair
EOF
	read -p "Selecione a Opção [0-6] > "
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
		sudo ufw status | grep "$UFW_PROFILE"
		read -p "Pressione [Enter] para continuar"
		sleep 2
		;;

	2)
                echo "Ativando Samba para Compartilhar (iniciar serviços + Firewall:"
		systemctl start "$SAMBA_SERVICE_SMBD"
		systemctl start "$SAMBA_SERVICE_NMBD"
		ufw allow "$UFW_PROFILE" 
		sleep 2
		echo "Samba Ativado."
		read -p "Pressione [Enter] para continuar"
		;;

	3)
		echo "Iniciando serviço de Compartilhamento local (apenas SMBD): "
		echo "Esta opção não ajusta o firewall." 
		systemctl start "$SAMBA_SERVICE_SMBD"
		sleep 2
		echo "Serviço SMDB iniciado"
		read -p "Pressione [Enter] para continuar" 
		;;

	4)
		echo "Abrindo Informações específicas de IP: "
		ip -4 addr show eth1
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
		ufw delete allow "$UFW_PROFILE"
		sleep 2
		echo "Samba desativado."
		read -p "Pressione [Enter] para continuar"
		;;

	*)
		echo "Número inválido, tente novamente."
		;;
	esac
	sleep  3

done
echo "Encerrado com sucesso, obrigado!"

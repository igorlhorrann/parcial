#!/bin/sh

# Ativar o roteamento
echo 1 > /proc/sys/net/ipv4/ip_forward

# Limpar regras antigas
iptables -F

# Bloquear por padrão
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Permitir o próprio firewall
iptables -A INPUT -i lo -j ACCEPT

# Permitir conexões já estabelecidas
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Permitir funcionários acessarem o site
iptables -A FORWARD -s 172.30.1.0/24 -d 172.30.3.10 -p tcp --dport 80 -j ACCEPT

# Permitir clientes acessarem o site
iptables -A FORWARD -s 172.30.2.0/24 -d 172.30.3.10 -p tcp --dport 80 -j ACCEPT

echo "Firewall iniciado com sucesso!"

sleep infinity
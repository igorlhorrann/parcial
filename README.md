
# Firewall - Frutaria Boa Colheita

# 1. Objetivo

Este projeto simula a segurança de uma pequena frutaria usando Docker, Docker Compose e iptables.

O objetivo é permitir o acesso aos serviços necessários e bloquear conexões não autorizadas.

# 2. Contêineres

- firewall: controla o tráfego entre as redes.
- funcionario: representa o computador de um funcionário.
- cliente: representa o dispositivo de um cliente.
- web: servidor do site usando Nginx.
- banco: banco de dados PostgreSQL.

# 3. Redes

- funcionarios: rede interna da frutaria.
- clientes: rede dos visitantes.
- dmz: rede do servidor web.

# 4. Regras do firewall

A política padrão da cadeia FORWARD é DROP, bloqueando o tráfego encaminhado que não tenha uma regra de permissão.

As regras permitem que funcionários e clientes acessem o site pela porta 80.

O acesso dos clientes ao banco de dados é bloqueado.

Observação: o funcionário e o banco de dados compartilham a mesma rede interna, portanto essa comunicação ocorre diretamente, sem passar pelo firewall.

# 5. Como executar

Com o Docker Desktop aberto, execute:

    docker compose up -d --build

Para conferir os contêineres:

    docker compose ps

Para encerrar o projeto:

    docker compose down

# 6. Testes realizados

# Cliente acessando o site

Comando: docker compose exec cliente curl -I --max-time 5 http://172.30.3.10

Resultado: acesso permitido, com resposta HTTP 200 OK.

### Cliente tentando acessar o banco

comando: docker compose exec cliente sh -c "nc -zv -w 3 172.30.1.20 5432"

Resultado: conexão expirou por tempo, indicando que o acesso não foi estabelecido.

### Funcionário acessando o banco

comando: docker compose exec funcionario sh -c "apk add --no-cache netcat-openbsd && nc -zv -w 3 172.30.1.20 5432"

Resultado: conexão estabelecida na porta 5432.

### Funcionário acessando o site

comando: docker compose exec funcionario curl -I --max-time 5 http://172.30.3.10

Resultado: acesso permitido, com resposta HTTP 200 OK.

## 7. Conclusão

Os testes demonstraram o funcionamento do site e a separação entre a rede dos clientes e a rede interna da frutaria.

O firewall utiliza uma política de bloqueio padrão e regras específicas para permitir o tráfego autorizado.
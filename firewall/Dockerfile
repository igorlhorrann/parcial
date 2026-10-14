
FROM alpine:3.22

RUN apk add --no-cache iptables iproute2

COPY rules.sh /rules.sh

RUN chmod +x /rules.sh

CMD ["/bin/sh", "/rules.sh"]
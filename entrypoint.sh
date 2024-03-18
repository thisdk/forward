#!/bin/sh

sleep 2

cp -f /etc/supervisor/conf.d/supervisord.conf.backup /etc/supervisor/conf.d/supervisord.conf

WIREGUARD_IP=$(dig +short wireguard)

if [ $UDP_FEC ];then
    sed -i "s#UDP_FEC#$UDP_FEC#g" /etc/supervisor/conf.d/supervisord.conf
else
    sed -i "s#UDP_FEC#2:6#g" /etc/supervisor/conf.d/supervisord.conf
fi

if [ $FORWARD_ADDR ];then
    sed -i "s#FORWARD_ADDR#$FORWARD_ADDR#g" /etc/supervisor/conf.d/supervisord.conf
else
    sed -i "s#FORWARD_ADDR#$127.0.0.1:8585#g" /etc/supervisor/conf.d/supervisord.conf
fi

exec "$@"

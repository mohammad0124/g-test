#!/bin/sh

UUID=$(cat /etc/xray/uuid)
PRIVATE_KEY=$(cat /etc/xray/private_key)
PUBLIC_KEY=$(cat /etc/xray/public_key)
SHORT_ID=$(cat /etc/xray/short_id)

SNI_DOMAIN="${CODESPACE_NAME}-443.app.github.dev"

echo ""
echo "🚀 Your optimized VLESS+REALITY link:"
echo "vless://${UUID}@${SNI_DOMAIN}:443?encryption=none&security=reality&type=xhttp&mode=packet-up&sni=www.github.com&host=github.com&flow=xtls-rprx-vision&pbk=${PUBLIC_KEY}&sid=${SHORT_ID}#g2ray-iran"
echo ""

exec /usr/local/bin/xray -c /etc/config.json

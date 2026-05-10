#!/bin/sh

echo "📥 Downloading Xray-core..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases/latest | grep '"tag_name"' | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
if [ -z "$LATEST_VERSION" ]; then
    LATEST_VERSION="v26.3.27"  # نسخه پشتیبان
fi
wget -O ${PWD}/xray.zip https://github.com/XTLS/Xray-core/releases/download/${LATEST_VERSION}/Xray-linux-64.zip

echo "🔧 Installing..."
unzip xray.zip && chmod +x xray
mv xray /usr/local/bin/xray
rm -rf ${PWD}/*

echo "🔐 Generating random keys and UUID..."
RANDOM_UUID=$(cat /proc/sys/kernel/random/uuid)
SHORT_ID=$(openssl rand -hex 4)   # ۸ کاراکتر
# تولید کلیدهای REALITY با استفاده از خود Xray
KEYS=$(/usr/local/bin/xray x25519)
PRIVATE_KEY=$(echo "$KEYS" | grep "Private key" | awk '{print $3}')
PUBLIC_KEY=$(echo "$KEYS" | grep "Public key" | awk '{print $3}')

# ذخیره برای استفاده در زمان اجرا (entrypoint)
mkdir -p /etc/xray
echo "$RANDOM_UUID" > /etc/xray/uuid
echo "$PRIVATE_KEY" > /etc/xray/private_key
echo "$PUBLIC_KEY" > /etc/xray/public_key
echo "$SHORT_ID" > /etc/xray/short_id

# جایگزینی متغیرها در فایل کانفیگ
sed -i "s/__UUID__/${RANDOM_UUID}/g" /etc/config.json
sed -i "s/__PRIVATE_KEY__/${PRIVATE_KEY}/g" /etc/config.json
sed -i "s/__SHORT_ID__/${SHORT_ID}/g" /etc/config.json

echo "✅ Installation complete."
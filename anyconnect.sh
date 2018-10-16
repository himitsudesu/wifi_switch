#!/bin/sh

# 接続先エイリアスまたはIPアドレス
ADDR=${VPN_ANYCONNECT_ADDR}
# ユーザー名
USER=${VPN_ANYCONNECT_USER}
# パスワード
PASS=${VPN_ANYCONNECT_PASS}
# タイムアウト
TIMEOUT=5

expect -c "
    set timeout ${TIMEOUT}
    spawn /opt/cisco/anyconnect/bin/vpn connect ${ADDR}
    expect \“Username:\”
    send \"${USER}\n\"
    expect \"Password:\"
    send \"${PASS}\n\"
    expect \"state: Connected\"
    exit 0
"
#! /bin/bash --login

# wifi接続状況を判定して、自動的にVPN接続
#
# 以下の環境変数の定義が必要
# .bashrc あたりに記載
# 
#   VPN_ANYCONNECT_ADDR : AnyConnectで使用する接続先
#   VPN_ANYCONNECT_USER : AnyConnectで使用するユーザ名
#   VPN_ANYCONNECT_PASS : AnyConnectで使用するパスワード
# 
# ex)
#   export VPN_ANYCONNECT_ADDR=https://domain/anyconnect
#   export VPN_ANYCONNECT_USER=my_anyconnect_user
#   export VPN_ANYCONNECT_PASS=my_anyconnect_password


# ------------------------------------------------------
# config start

# VPNを使用するネットワーク環境
use_vpn="Automatic"

# 自動接続しないSSID
exclude_ssid="mywifi"

# wifi接続情報の保存先( SSID の切り出しに使用 )
airport_path="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

# config end
# ------------------------------------------------------

# anyconnect 終了
~/bin/anyconnect_disconnect.sh
killall -HUP "Cisco AnyConnect Secure Mobility Client"

# wifi接続時
if air_info=($(eval "$airport_path" -I | grep -E "^ *(agrCtlRSSI|state|SSID):" | awk '{print $2}')) ; then
  rssi=${air_info[0]}
  state=${air_info[1]}
  ssid=${air_info[2]}

  # 現在の接続環境を取得
  netenv=`networksetup -getcurrentlocation`
  if [ $netenv = $use_vpn ]; then
    if [ $ssid != $exclude_ssid ]; then
      # 接続確認まで待機
      while :
      do
        # googleへのping成功で、ネットワーク接続完了とみなす
        ping www.google.com -c 1 >> /dev/null
        if [ $? == 0 ]; then
          break;
        fi
        sleep 1
      done
      
      # 接続
      ~/bin/anyconnect.sh
      open "/Applications/Cisco/Cisco AnyConnect Secure Mobility Client.app"
    fi
  fi
fi

echo "ssid: $ssid"
echo "netenv: $netenv"
echo 'Connected successfully.'
exit 0

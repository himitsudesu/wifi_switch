# wifi_switch

AnyConnect VPN へ自動的に接続する bash script
macbook pro( Mojave ) にて動作

# 設定方法
1. ~/bin へ全てのファイルを保存
2. wifiswitch.sh のconfig を自分の環境に合わせて変更
2. 追加したファイルへ実行権を追加
3. .bashrc へ環境変数を追加
4. ~/bin/wifiswitch.sh を実行

# 設定詳細
## wifiswitch.sh の変更
自分の環境に合わせて更新が必要

```
# VPNを使用するネットワーク環境
use_vpn="Automatic"     <- 多分そのままで動く

# 自動接続しないSSID
exclude_ssid="mywifi"   <- 除外したいSSIDを記載　　複数SSIDには未対応
```
## 実行権の追加
以下のコマンドを実行
```
cd ~/bin
chmod +x anyconnect.sh
chmod +x wifiswitch.sh
chmod +x anyconnect_disconnect.sh
```

## 追加する環境変数
1. VPN_ANYCONNECT_ADDR : AnyConnectで使用する接続先
2. VPN_ANYCONNECT_USER : AnyConnectで使用するユーザ名
3. VPN_ANYCONNECT_PASS : AnyConnectで使用するパスワード


## 補足
Mac では、plist ファイルを作って、ファイル監視をすると
ネットワークの切り替えが監視できるので、以下のファイルを作ると
幸せになれるかもしれない


~/Library/LaunchAgents/github.com.himitsudesu.wifiswich.plist
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
          "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>github.com.himitsudesu.wifiswich</string>
    <key>ProgramArguments</key>
    <array>
      <string>/bin/bash</string>
      <string>--login</string>
      <string>/Users/himitsudesu/bin/wifiswich/wifiswitch.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>/dev/null</string>
    <key>StandardOutPath</key>
    <string>/dev/null</string>
    <key>WatchPaths</key>
    <array>
      <string>/Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist</string>
      <string>/Library/Preferences/SystemConfiguration/preferences.plist</string>
    </array>
  </dict>
</plist>
```

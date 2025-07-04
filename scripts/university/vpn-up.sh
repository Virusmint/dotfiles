#!/usr/bin/bash

connection_name=$(
  nmcli -t -g type,name connection |
    grep -Po '^vpn:\K.*' |
    sed 's/\\:/:/g' | fzf
)

if [[ -z "$connection_name" ]]; then
  echo "Invalid VPN connection selected. Exiting."
  exit 1
fi

eval "$(nmcli -t -g vpn.data connection show "$connection_name" |
  grep -Po '(^|[ ,])(protocol|gateway)\ =\ [^,]*' |
  sed 's/ //g')"
eval "$(openconnect-sso --authenticate shell -s "$gateway")"
ip=$(getent hosts securevpn.mcgill.ca | awk '{ print $1 }')
echo "vpn.secrets.resolve:$gateway:$ip"
nmcli connection up "$connection_name" --ask \
  passwd-file <(
    echo "vpn.secrets.gateway:$gateway"
    echo "vpn.secrets.cookie:$COOKIE"
    echo "vpn.secrets.gwcert:$FINGERPRINT"
    echo "vpn.secrets.resolve:'$gateway:$ip'"
  )

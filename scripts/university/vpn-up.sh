#!/usr/bin/bash

connection_name="McGillVPN"

eval "$(nmcli -t -g vpn.data connection show "$connection_name" |
  grep -Po '(^|[ ,])(protocol|gateway)\ =\ [^,]*' |
  sed 's/ //g')"

eval "$(openconnect-sso --authenticate shell -s "$gateway")"
ip=$(getent hosts "$gateway" | awk '{ print $1 }')
echo "vpn.secrets.resolve:$gateway:$ip"
nmcli connection up "$connection_name" --ask \
  passwd-file <(
    echo "vpn.secrets.gateway:$gateway"
    echo "vpn.secrets.cookie:$COOKIE"
    echo "vpn.secrets.gwcert:$FINGERPRINT"
    echo "vpn.secrets.resolve:'$gateway:$ip'"
  )

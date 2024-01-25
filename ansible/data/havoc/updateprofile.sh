#!/bin/bash

cp /opt/Havoc/profiles/ctf-profile.yaotl.bk /opt/Havoc/profiles/ctf-profile.yaotl
chown user:user /opt/Havoc/profiles/ctf-profile.yaotl
IP=$(ip -4 -o a show dev tun0 2>/dev/null | awk '{print $4}' | cut -d '/' -f1)
sed -i "s/xXlistenerbindaddressXx/${IP:-0.0.0.0}/g" /opt/Havoc/profiles/ctf-profile.yaotl
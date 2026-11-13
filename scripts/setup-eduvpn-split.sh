#!/usr/bin/env bash
# Preserve normal Internet/Tailscale routes; use eduVPN only for IVI/DAS.
set -euo pipefail
(( EUID == 0 )) || { echo 'Run with sudo.' >&2; exit 1; }
connection='Wired connection 1'
# eduVPN currently uses table 51860, with its catch-all at priority 3.
# Priority 1 retains the existing Tailscale exceptions and adds cluster routes.
# If the VPN table is absent, lookup falls through to the normal connection.
for address in 146.50.10.46 146.50.10.102; do
    rule="priority 1 to $address/32 table 51860"
    if ! nmcli -g ipv4.routing-rules connection show "$connection" | grep -Fq "$rule"; then
        nmcli connection modify "$connection" +ipv4.routing-rules "$rule"
    fi
    if ! ip -4 rule show | grep -Fq "to $address lookup 51860"; then
        ip -4 rule add priority 1 to "$address/32" table 51860
    fi
done
for family in 4 6; do
    rule='priority 2 table 254'
    if ! nmcli -g "ipv$family.routing-rules" connection show "$connection" | grep -Fq "$rule"; then
        nmcli connection modify "$connection" "+ipv$family.routing-rules" "$rule"
    fi
    if ! ip -"$family" rule show | grep -Eq '^2:.*lookup main$'; then
        ip -"$family" rule add priority 2 lookup main
    fi
done
printf '%s\n' 'Routes installed. eduVPN is not activated by this script.'
printf '%s\n' 'VPN DNS settings remain unchanged; verify DNS separately.'
ip -4 rule show
ip -6 rule show

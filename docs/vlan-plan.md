# VLAN Plan & IP Addressing

This document defines the VLANs, subnets, intended purpose and security guidance used across the hospital enterprise lab.

## Address space
We use private block: `10.10.0.0/16` for HQ networks. Branch networks may use separate /16s (e.g., `10.110.0.0/16`) to avoid overlapping.

## VLAN table

| VLAN ID | Name | Subnet | Purpose | Notes |
|--------:|------|--------|---------|-------|
| 10 | MGMT | 10.10.10.0/24 | Management network for devices & console access | Only accessible from admin workstations; SSH restricted; MFA for GUI where possible |
| 20 | SERVERS | 10.10.20.0/24 | Application servers (EMR, DB, Zabbix, Logstash) | Servers are static IPs; backups & monitoring allowed |
| 30 | STAFF | 10.10.30.0/24 | Staff workstations & laptops | 802.1X for auth; access to servers via firewall-permitted ports |
| 40 | ADMIN | 10.10.40.0/24 | Administrative workstations (finance, HR) | Least-privilege; more restrictive ACLs than STAFF |
| 50 | CLINICAL | 10.10.50.0/24 | EMR, PACS, medical device gateways | Isolated; only allowed flows to specific server IPs/ports; no direct internet access |
| 60 | IOT/TELEMETRY | 10.10.60.0/24 | Device telemetry collectors & IoT | High monitoring, limited access, rigid patch cycles |
| 70 | GUEST | 10.10.70.0/24 | Guest Wi-Fi / ephemeral devices | Internet-only; strictly blocked to internal subnets |
| 80 | DMZ | 10.10.80.0/24 | Public-facing services (portal, VPN endpoints) | Hardened hosts; reverse-proxy & WAF recommended |

## DHCP ranges & reservations
- STAFF: `10.10.30.100 - 10.10.30.200` (DHCP)
- GUEST: `10.10.70.100 - 10.10.70.250` (DHCP)
- SERVERS & CLINICAL: static reservations (e.g., `.10 - .50`)

## VLAN assignment strategy
- Use **dynamic VLAN assignment** via RADIUS for 802.1X-capable ports (staff vs guest)
- For medical devices without 802.1X, place ports in the Clinical VLAN and restrict by MAC + ACLs

## Notes on routing & inter-VLAN access
- Inter-VLAN routing occurs at the core L3 switch (SVIs). Access control is enforced at the edge firewall (pfSense) and via ACLs on the core switch where required.
- Use VRFs if traffic separation must be enforced at the routing level.


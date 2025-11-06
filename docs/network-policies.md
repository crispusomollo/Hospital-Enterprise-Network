# Network Policies & Firewall Rules

This document gives the policy-level rules, examples for firewall configurations and enforcement mechanisms for the hospital network.

## Principles
1. **Least Privilege:** Allow only required services between VLANs; default deny otherwise.
2. **Segmentation:** Clinical systems are isolated from general-purpose networks.
3. **Identity-Based Access:** Use AD + RADIUS for 802.1X and role-based VLAN assignment.
4. **Logging & Monitoring:** All firewall decisions and device logs are centralized (ELK/Zabbix).
5. **Auditability:** Change-control for firewall rules and network configs; all changes reviewed.

## Example high-level firewall rules (ordered)
1. **Allow MGMT -> Firewall GUI**
   - Source: `10.10.10.0/24` (MGMT)
   - Destination: `10.10.10.2` (pfSense GUI)
   - Ports: `TCP 443` (HTTPS)
   - Action: ALLOW

2. **Allow Staff -> Servers (limited)**
   - Source: `10.10.30.0/24`
   - Destination: `10.10.20.0/24`
   - Ports: `TCP 80,443,389,636,5432` (HTTP/HTTPS/LDAP(LDAPS)/Postgres)
   - Action: ALLOW

3. **Block Clinical -> Internet (default)**
   - Source: `10.10.50.0/24`
   - Destination: `!10.10.0.0/16` (not internal)
   - Action: DENY
   - Exceptions: allow to vendor update servers (by IP) and to EMR gateway only

4. **Guest -> Internet only**
   - Source: `10.10.70.0/24`
   - Destination: `any`
   - Action: ALLOW
   - Then: add rule `Guest -> Internal` DENY for `10.10.0.0/16`

5. **DMZ Service NAT**
   - Public HTTPS -> `10.10.80.10` (web portal)
   - Ensure backend access restricted to necessary ports only

## ACL examples (Cisco IOS style)
```text
! Allow staff to servers on required ports
ip access-list extended STAFF_TO_SERVERS
 permit tcp 10.10.30.0 0.0.0.255 10.10.20.0 0.0.0.255 eq 443
 permit tcp 10.10.30.0 0.0.0.255 10.10.20.0 0.0.0.255 eq 80
 permit tcp 10.10.30.0 0.0.0.255 10.10.20.0 0.0.0.255 eq 389
 deny ip any 10.10.50.0 0.0.0.255
```

## Identity & NAC

* **802.1X** for staff ports (wired & wireless). Use FreeRADIUS integrated with AD for authentication and dynamic VLAN assignment.
* **MAC authentication bypass** for approved medical devices if 802.1X not supported; pair with strict ACLs and device whitelisting.

## VPN & Remote Access Policy

* Administrative VPN access requires MFA and must originate from allowed IPs.
* Site-to-site IPsec uses strong ciphers (AES-256, SHA-256, DH Group 14+). Pre-shared keys in lab only — use certificates for production.

## Logging & Alerting

* Forward firewall logs and system logs to ELK/OpenSearch.
* Alerts: IPSec down, repeated failed auth attempts, suspicious outbound spikes from Clinical VLAN.

## Change Management & Compliance

* Store firewall rule changes in repository with clear commit messages.
* Maintain an audit trail of who changed what and approved PRs before merging into `main`.

## Incident Response (network brief)

1. Isolate affected VLAN (apply ACL to block lateral traffic)
2. Capture relevant logs (ELK query time-range)
3. Identify patient-impacting services and failover if required
4. Restore services and conduct post-incident review


## Hospital Enterprise Network - VLAN & Gateway Configs

This folder contains lab-ready configuration artifacts for the Hospital Enterprise Network project. Use these files to bootstrap your EVE-NG / GNS3 lab or to adapt to a physical environment. This directory contains example configurations for devices used in the lab. 
**Never commit real credentials or private keys.
** Replace placeholder values (like `<PRE_SHARED_KEY>` and `<REPLACE_WITH_STRONG_SECRET>`) before deployment.

### Files:
- `core-switch.cfg` — Cisco IOS L3 switch config (VLANs, SVIs, trunk)
- `branch-router.cfg` — Branch Router (site-to-site IPsec example and subinterfaces)
- `pfsense-rules.xml` — Conceptual pfSense rules & IPsec example (apply via GUI/import)
- `pfsense-backup.xml` — importable partial pfSense config (VLANs, DHCP scopes, firewall rules, IPsec stub). **Review and replace placeholders before use**.
- `cisco-startup-config.txt` — example startup-config for a Cisco L3 switch (SVIs, trunk, access ports, OSPF). Replace secrets before deployment.
- `README.md` — this file.

### How to use
1. In pfSense (lab): Backup current config.
2. Import `pfsense-backup.xml` via `Diagnostics -> Backup & Restore -> Restore` (or use as a reference to manually create VLANs & rules).
3. On your Cisco L3 switch: paste `cisco-startup-config.txt` into the CLI (preferably in configuration mode). Save and verify.


### Important notes
- These configs are for **lab and demonstration only**. Do not use in production without a security review.
- Replace all placeholder secrets (username/password/PSKs) before connecting to any real network.
- Consider using certificate-based IPsec and strong ciphers in production.


### Support
If you want, I can:
- Produce a pfSense XML with certificates (test CA) for lab use.
- Convert the Cisco config into an Ansible playbook to deploy across multiple switches.


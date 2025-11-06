# 🏥 Hospital Enterprise Network Architecture Project

A fully documented **enterprise-grade multi-site network** designed for a healthcare environment.  
This project simulates a **Headquarters Datacenter + Remote Clinics** with secure segmentation, VPN tunnels, centralized authentication, monitoring, and logging.

The goal is to demonstrate **professional network engineering capability**, including:
- Network design & architecture
- Security and Zero-Trust segmentation
- Identity-based access control (AD + RADIUS + 802.1X)
- Firewall policy design and change control
- Network monitoring & observability

---

## 🗂 Topology Overview

**Sites**
| Site | Description |
|------|-------------|
| HQ Datacenter | Core switching, firewalls, AD/LDAP, EMR systems, monitoring stack |
| Clinic A | Branch router, VLAN segmentation, VPN backhaul to HQ |
| Clinic B | Same as Clinic A (scales horizontally) |

**Core Technologies Used**
- **Routing & Switching:** Cisco IOS / FRRouting
- **Firewall:** pfSense or OPNsense (HA optional)
- **VPN:** IPsec / OpenVPN site-to-site
- **Authentication:** Active Directory / LDAP + FreeRADIUS
- **Monitoring:** Zabbix + Grafana dashboards
- **Logging:** Elastic Stack / OpenSearch + Filebeat

---

## 🔐 VLAN & Security Segmentation (Zero-Trust Model)

| VLAN | Purpose | Subnet |
|------|---------|--------|
| 10 | Management | 10.10.10.0/24 |
| 20 | Servers | 10.10.20.0/24 |
| 30 | Staff Workstations | 10.10.30.0/24 |
| 40 | Guest WiFi | 10.10.40.0/24 |
| 50 | Clinical Systems (EMR, PACS, RIS) | 10.10.50.0/24 |
| 70 | IoT / Medical Devices | 10.10.70.0/24 |

**Guest → No internal access**  
**Clinical → Limited access only to EMR servers**  
**802.1X used where applicable for identity-based port control**

---

## 🧱 Repository Structure

```
docs/ # Documentation and build notes
configs/ # Network and firewall configs
diagrams/ # Network topology diagrams
monitoring/ # Zabbix / Grafana templates
logging/ # ELK/OpenSearch configs
scripts/ # Test and automation tools
demo/ # Short video demonstrations
```

---

## 🚀 Deployment Guide

Start with the EVE-NG / GNS3 lab setup:

**→** `docs/lab-setup.md`

Then configure VLANs & core routing:

**→** `docs/vlan-plan.md`

Then set up authentication & firewall rules:

**→** `docs/network-policies.md`

---

## 💡 Demonstration Videos

| Demo | Description |
|------|-------------|
| Failover Test | Firewall HA or VPN failover event |
| VLAN Isolation | Proof of no lateral traffic |
| SOC Dashboard | Live monitoring & alerting |

---

## 📜 License

MIT License — free for learning and professional demonstration.

---

## ✍️ Author

**Crispus Omollo**  
Senior ICT Officer | Network & Infrastructure Support Engineer  
📧 crispusomollo@gmail.com


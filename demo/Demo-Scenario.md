# DEMO-SCENARIO.md

## Network Monitoring & Incident Response Demonstration Scenario

This scenario demonstrates how the network design, monitoring systems, and log analytics pipeline work together to detect, analyze, and respond to an issue affecting an enterprise environment.

---

## Scenario Overview

**Situation:** Users in the Finance department report slow access to the ERP application.

**Goal:** Identify the cause, confirm the impact, and resolve the issue using pfSense, Zabbix, and the ELK Stack.

---

## Step 1 — Verify Network Health

1. Run the network health script:

   ```bash
   ./scripts/network-health-check.sh
   ```
2. Confirm whether gateway or switch latency is elevated.
3. If high latency is detected, note timestamps.

Expected Output Example:

```
[WARN] High latency detected on VLAN 30 (Finance)
```

---

## Step 2 — Check pfSense Firewall & VLAN Routing

1. Log into pfSense Web UI.
2. Navigate to **Status > Interfaces** and confirm link and VLAN status.
3. Review firewall logging under **Status > System Logs > Firewall** for blocked internal traffic.

**Possible Findings:** Misconfigured ACL or overloaded interface.

---

## Step 3 — Use Zabbix to Identify Network Load or Device Issues

1. Open Zabbix Dashboard.
2. Check the following:

   * Switch port utilization (Finance VLAN trunk ports)
   * pfSense CPU and memory utilization
   * ICMP packet loss graphs
3. Look for spikes in bandwidth or errors.

**If a switch port shows high utilization:** Suspect broadcast, loop, or large data transfers.

---

## Step 4 — Investigate Logs via ELK Stack

1. Open Kibana.
2. Navigate to **Discover** and filter logs:

   ```
   fields.log_origin : "hospital-network" AND vlan : "30"
   ```
3. Look for repeating error patterns or traffic bursts.

**Example Finding:** A misconfigured backup script copying data hourly over VLAN 30.

---

## Step 5 — Apply Fix

**Fix Example:** Move backup traffic to a dedicated service VLAN.

1. Adjust VLAN assignments on the switch.
2. Update pfSense VLAN & routing rules.
3. Re-run health check and confirm latency returns to normal.

---

## Outcome

The monitoring system allowed early detection of abnormal network behavior and guided troubleshooting efforts. Root cause was traced to backup data saturating the Finance VLAN.

**Key Takeaways:**

* VLAN segmentation limits blast radius.
* Zabbix helps correlate bandwidth spikes to affected hosts.
* ELK provides deep log visibility into what caused the issue.

This scenario can be used as a portfolio demonstration, interview walkthrough, or documentation for team knowledge transfer.


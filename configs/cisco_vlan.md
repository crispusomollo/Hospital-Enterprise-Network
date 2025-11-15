1. Create VLANs

conf t

vlan 10
 name MANAGEMENT
exit

vlan 20
 name SERVERS
exit

vlan 30
 name STAFF
exit

vlan 40
 name GUEST
exit

vlan 50
 name CLINICAL
exit

vlan 70
 name IOT
exit


2. Configure Trunk Port to PfSense

Assume PfSense is connected on GigabitEthernet0/1:

interface g0/1
 description Uplink-to-PfSense
 switchport mode trunk
 switchport trunk native vlan 10
 switchport trunk allowed vlan 10,20,30,40,50,70
 spanning-tree portfast trunk


3. Assign Access Ports to VLANs

*Management VLAN Example

interface g0/2
 description Management-PC
 switchport mode access
 switchport access vlan 10
 spanning-tree portfast


*Servers VLAN Example

interface g0/3
 description Database-Server
 switchport mode access
 switchport access vlan 20
 spanning-tree portfast

*Staff Workstations VLAN Example

interface g0/10
 description Workstation-01
 switchport mode access
 switchport access vlan 30
 spanning-tree portfast

*Guest WiFi AP VLAN Example

interface g0/15
 description Guest-WiFi-AP
 switchport mode access
 switchport access vlan 40
 spanning-tree portfast

*Clinical Devices VLAN Example

interface g0/20
 description Radiology-PACS-Viewer
 switchport mode access
 switchport access vlan 50
 spanning-tree portfast

*IoT / Medical Devices VLAN Example

interface g0/25
 description Vital-Signs-Monitor
 switchport mode access
 switchport access vlan 70
 spanning-tree portfast

4. Save Configuration
wr mem


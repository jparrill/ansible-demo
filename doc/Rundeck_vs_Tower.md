# Rundeck vs Ansible Tower
This file contains my notes about a comparison between Rundeck and Ansible Tower products (**it's my opinion**)

## Rundeck
- Opensource
- Java 1.7.0
  - Java Server
  - Start script based on Init
- Not much intuitive
- Don't have Orgs/Teams/Credentials, just control through config files
- Hacky
- Free
- Step based, very cool on pipelining creation (This remembers me to Jenkins)
- Embedded notifications
- Dynamic invs based on java/groovy plugins

## Ansible Tower
- Red Hat Product
- Python 2.7.5
  - Services:
    - Httpd
    - Redis
    - PostgreSQL (could be also MongoDB, but not tested yet by me)
    - SupervisorD - Very important in case of service fail
    - Start script based on Systemd
- Intuitive
- Manage Orgs/Teams/Credentials/Users through WebUI
- Recursive in Inventories/Groups/Hosts as Ansible are, but also through WebUI
- All the pipelining based on YML files
- Cleaning Jobs (admin UI)
- DIY Notifications
- Dynamic invs based on scripts, editable on WebUI


My decision, for now Tower, why?:
- Java vs Python...Python wins
- Very defined services, and a interface with systemd
- Intuitive, very intuitive just 10-15 min to start working with it.
- Dynamic inventories better on tower because uses scripts based on all languages that the server could parse
- Security system, all through WebUI also with isolation between organizations
- Support, Tower has support through Red Hat, Rundeck is all community 

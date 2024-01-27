# IaC-CTFs

Clone this repository and create a new file called **terraform.tfvars**. Define variable values related to your AWS account inside (see **variables.tf** for guidance).

## Ansible playbooks

Below are details about the ansible playbooks available. Multiple playbooks can be run to set up various capabilities on the server, but it is up to you to review the details and make sure they won't interfere with each other e.g. trying to bind services to the same ports.

### OpenVPN

This playbook uploads a VPN config file to the server and creates a service to automatically connect to the vpn. This should probably be run before any other playbook if you're intending to bind any services to the vpn interface.

```
ansible-playbook -i ./ansible/hosts ./ansible/openvpn.yaml --private-key ./.ssh/id_rsa
```

Inputs (prompted when playbook is run):
- Path to VPN configuration file (.ovpn)

### Havoc C2

This sets up a Havoc Command and Control (C2) server. See https://github.com/HavocFramework/Havoc.

```
ansible-playbook -i ./ansible/hosts ./ansible/havoc.yaml --private-key ./.ssh/id_rsa
```

Inputs (prompted when playbook is run):
- Havoc C2 username
- Havoc C2 password

Bindings:
- 0.0.0.0:39862 - this is the port the Havoc server runs on and Havoc clients will connect to.
- ?.?.?.?:443 - an HTTPS listener will be created on this port. The bind address will be taken from the tun0 interface if it is available, otherwise it will bind on 0.0.0.0.

**Note**: This builds the server, but it does not build the Havoc client. You will need to do that locally to ensure it is compiled using the right version of GLIBC for your PC.

### BloodHound CE

This sets up a dockerised BloodHound CE instance on the server. See https://github.com/SpecterOps/BloodHound.

```
ansible-playbook -i ./ansible/hosts ./ansible/bloodhound.yaml --private-key ./.ssh/id_rsa
```

Inputs (prompted when playbook is run):
- BloodHound admin username
- BloodHound admin password (this will have to be changed again on first login)

Bindings:
- 0.0.0.0:8080 - The BloodHound CE GUI
- 127.0.0.1:7474 - The Neo4j web console
- 127.0.0.1:7687 - The Neo4j database port
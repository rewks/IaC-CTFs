# IaC-CTFs

Clone this repository and create a new file called **terraform.tfvars**. Define variable values related to your AWS account inside (see **variables.tf** for guidance).

## Ansible playbooks

Below are details about the ansible playbooks available. Multiple playbooks can be run to set up various capabilities on the server, but it is up to you to review the details and make sure they won't interfere with each other e.g. trying to bind services to the same ports.

### OpenVPN

This playbook reads in a path to a vpn config file, then uploads it to the server and creates a service to automatically connect to the vpn. This should probably be run before any other playbook if you're intending to bind any services to the vpn interface.

```
ansible-playbook -i ./ansible/hosts ./ansible/openvpn.yaml --private-key ./.ssh/id_rsa
```

### Havoc C2

This sets up a Havoc Command and Control (C2) server. See https://github.com/HavocFramework/Havoc. To run this playbook:

```
ansible-playbook -i ./ansible/hosts ./ansible/havoc.yaml --private-key ./.ssh/id_rsa
```

Bindings:
- 0.0.0.0:39862 - this is the port the Havoc server runs on and Havoc clients will connect to.
- ?.?.?.?:443 - an HTTPS listener will be created on this port. The bind address will be taken from the tun0 interface if it is available, otherwise it will bind on 0.0.0.0.
- ?.?.?.?:445 - an SMB listener will be created on this port. The bind address will be taken from the tun0 interface if it is available, otherwise it will bind on 0.0.0.0.
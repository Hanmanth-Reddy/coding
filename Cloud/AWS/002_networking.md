Network security groups(NSG) needs attach to subnets and VM NIC's
VPC firewall rules are attached at the VPC/network level and apply to instances by tags/service accounts.
Azure NSG and GCP VPC firewall rules are stateul.

AWS NACL is network level and stateless
AWS SG are at VM level and stateful
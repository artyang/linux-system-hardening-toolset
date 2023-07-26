#!/usr/bin/env python3

import ipaddress
import sys

def subnet_calc(network_address, subnet_mask, num_subnets):
    try:
        network = ipaddress.IPv4Network(network_address + "/" + subnet_mask, strict=False)
        subnets = list(network.subnets(new_prefix=int(network.prefixlen + num_subnets)))
        return subnets
    except ValueError as e:
        return str(e)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: subnet_calculator.py <NETWORK_ADDRESS> <SUBNET_MASK> <NUM_SUBNETS>")
        sys.exit(1)

    network_address = sys.argv[1]
    subnet_mask = sys.argv[2]
    num_subnets = int(sys.argv[3])

    subnets = subnet_calc(network_address, subnet_mask, num_subnets)
    for i, subnet in enumerate(subnets):
        print(f"Subnet {i+1}: {subnet}")

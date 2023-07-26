#!/usr/bin/env python3

import ipaddress
import sys

def ipv6_subnet_calc(network_address, prefixlen, num_subnets):
    try:
        network = ipaddress.IPv6Network(network_address + "/" + str(prefixlen), strict=False)
        subnets = list(network.subnets(new_prefix=prefixlen + num_subnets))
        return subnets
    except ValueError as e:
        return str(e)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: ipv6_subnet_calculator.py <NETWORK_ADDRESS> <PREFIX_LENGTH> <NUM_SUBNETS>")
        sys.exit(1)

    network_address = sys.argv[1]
    prefixlen = int(sys.argv[2])
    num_subnets = int(sys.argv[3])

    subnets = ipv6_subnet_calc(network_address, prefixlen, num_subnets)
    for i, subnet in enumerate(subnets):
        print(f"Subnet {i+1}: {subnet}")

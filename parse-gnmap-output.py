def parse_greppable_nmap_results(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    parsed_results = []
    current_host = {}
    for line in lines:
        line = line.strip()
        if line.startswith('#'):
            # Start of a new host
            if current_host:
                parsed_results.append(current_host)
                current_host = {}
            current_host['Host'] = line[1:]
        else:
            # Parsing key-value pairs
            key_value = line.split('\t')
            if len(key_value) == 2:
                key, value = key_value
                current_host[key] = value

    # Append the last host
    if current_host:
        parsed_results.append(current_host)

    return parsed_results


# Example usage
nmap_file_path = 'path/to/greppable_nmap_results.txt'
results = parse_greppable_nmap_results(nmap_file_path)

# Print the parsed results
for host in results:
    print("Host:", host['Host'])
    print("IP Address:", host.get('Host IP'))
    print("Ports:")
    for port in host.get('Ports', '').split(','):
        port_info = port.split('/')
        if len(port_info) == 7:
            port_num, state, proto, service, product, version, extrainfo = port_info
            print(f"- Port: {port_num} ({proto})")
            print(f"  State: {state}")
            print(f"  Service: {service}")
            print(f"  Product: {product}")
            print(f"  Version: {version}")
            print(f"  Extra Info: {extrainfo}")
    print()

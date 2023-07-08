import subprocess

def get_mac_address(interface):
    result = subprocess.run(['ip', 'link', 'show', interface], capture_output=True, text=True)
    output = result.stdout.strip()
    lines = output.split('\n')
    for line in lines:
        if 'link/ether' in line:
            mac_address = line.split(' ')[1]
            return mac_address
    return None

# Network interface to monitor
interface = 'eth0'

# Get initial MAC address
initial_mac = get_mac_address(interface)
if initial_mac:
    print(f"Initial MAC Address: {initial_mac}")
else:
    print("Unable to retrieve initial MAC address.")

while True:
    # Get current MAC address
    current_mac = get_mac_address(interface)
    if current_mac and current_mac != initial_mac:
        print(f"MAC Address has changed! New MAC: {current_mac}")
        break

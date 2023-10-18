# run from bash pip install requests
# obtain your public IP address by making an HTTP request to a service that returns your IP address

import requests

def get_public_ip():
    try:
        # Use a public IP service like ifconfig.me to get your IP address
        response = requests.get('https://ifconfig.me')
        if response.status_code == 200:
            return response.text.strip()
        else:
            return "Failed to retrieve public IP"
    except Exception as e:
        return str(e)

if __name__ == "__main__":
    public_ip = get_public_ip()
    print("Your public IP address is:", public_ip)

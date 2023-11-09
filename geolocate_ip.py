#given a list of IPs, geolocate them, and output to a csv. 
#useful in tracking attackers
import csv
import requests

def get_geolocation(ip):
    url = f"https://ipinfo.io/{ip}/json"
    response = requests.get(url)
    data = response.json()
    return data

def geolocate_ips(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w', newline='') as outfile:
        csv_writer = csv.writer(outfile)
        
        # Write CSV header
        csv_writer.writerow(["IP", "Hostname", "City", "Region", "Country", "Location", "Organization"])

        # Read each IP address from the file and get its geolocation
        for ip in infile:
            ip = ip.strip()
            geolocation = get_geolocation(ip)
            
            # Write geolocation data to CSV
            csv_writer.writerow([ip, geolocation.get("hostname", ""),
                                geolocation.get("city", ""), geolocation.get("region", ""),
                                geolocation.get("country", ""), geolocation.get("loc", ""),
                                geolocation.get("org", "")])

    print(f"Geolocation results written to {output_file}")

if __name__ == "__main__":
    input_file = input("Enter the path to the input file: ")
    output_file = input("Enter the path to the output CSV file: ")
    
    geolocate_ips(input_file, output_file)

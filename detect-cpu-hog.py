import psutil

# Threshold for CPU usage percentage
threshold = 80

# Get CPU usage percentage for each process
cpu_percentages = psutil.cpu_percent(percpu=True)

# Get the list of processes and their CPU usage
processes = []
for process in psutil.process_iter(['pid', 'name', 'cpu_percent']):
    processes.append({
        'pid': process.info['pid'],
        'name': process.info['name'],
        'cpu_percent': process.info['cpu_percent']
    })

# Filter processes with CPU usage above the threshold
cpu_hogs = [process for process in processes if process['cpu_percent'] > threshold]

# Print CPU hogs
if cpu_hogs:
    print("CPU Hogs:")
    for process in cpu_hogs:
        print(f"PID: {process['pid']}, Name: {process['name']}, CPU Percent: {process['cpu_percent']}")
else:
    print("No CPU hogs found.")

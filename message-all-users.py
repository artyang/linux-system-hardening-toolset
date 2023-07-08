import subprocess

# Message to send
message = "Hello, this is a broadcast message to all logged-on users!"

# Send message to all logged-on users
subprocess.run(['wall', message])

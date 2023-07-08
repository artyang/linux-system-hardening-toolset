import os

# Directory path
directory_path = '/path/to/directory'  # Replace with the desired directory path

# Set the sticky bit
os.chmod(directory_path, 0o1777)

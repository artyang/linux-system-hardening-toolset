import os

def detect_large_files(directory, threshold):
    large_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            file_size = os.path.getsize(file_path)
            if file_size > threshold:
                large_files.append((file_path, file_size))
    return large_files

# Directory to scan for large files
directory = 'DIRECTORY_PATH'

# Threshold file size in bytes (e.g., 1 MB = 1024 * 1024 bytes)
threshold = THRESHOLD_SIZE_IN_BYTES

# Get the list of large files
large_files = detect_large_files(directory, threshold)

# Print the list of large files
if large_files:
    print("Large Files:")
    for file_path, file_size in large_files:
        print(f"File: {file_path}")
        print(f"Size: {file_size} bytes")
        print()
else:
    print("No large files found.")

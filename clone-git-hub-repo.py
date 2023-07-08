import subprocess

# GitHub repository details
repository_url = 'https://github.com/username/repository.git'  # Replace with the URL of the repository
destination_folder = 'destination_folder'  # Replace with the desired destination folder name

# Clone the GitHub repository
clone_command = f'git clone {repository_url} {destination_folder}'
subprocess.run(clone_command, shell=True)

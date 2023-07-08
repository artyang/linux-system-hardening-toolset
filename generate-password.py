import random

# List of common words for password generation
word_list = [
    'apple', 'banana', 'cherry', 'orange', 'kiwi', 'grape', 'mango',
    'carrot', 'potato', 'broccoli', 'tomato', 'cabbage', 'pepper',
    'elephant', 'giraffe', 'lion', 'tiger', 'zebra', 'monkey', 'gorilla',
    'sun', 'moon', 'star', 'sky', 'cloud', 'rain', 'snow', 'wind'
]

def generate_password(length):
    # Select a random word from the list
    word = random.choice(word_list)
    word_length = len(word)

    # Calculate the number of random characters needed
    num_chars = length - word_length

    # Generate random characters
    chars = [chr(random.randint(33, 126)) for _ in range(num_chars)]

    # Shuffle the characters
    random.shuffle(chars)

    # Combine the word and random characters
    password = word + ''.join(chars)
    return password

# Length of the password
password_length = 12

# Generate the password
password = generate_password(password_length)

# Print the generated password
print("Generated Password:", password)

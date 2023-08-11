import base64

def decode_base64(encoded_string):
    try:
        decoded_bytes = base64.b64decode(encoded_string)
        decoded_string = decoded_bytes.decode('utf-8')
        return decoded_string
    except Exception as e:
        return f"Error decoding Base64: {str(e)}"

if __name__ == "__main__":
    encoded_string = input("Enter the Base64-encoded string: ")
    decoded_result = decode_base64(encoded_string)
    print("Decoded result:", decoded_result)

import base64

def encode_to_base64(input_string):
    try:
        encoded_bytes = base64.b64encode(input_string.encode('utf-8'))
        encoded_string = encoded_bytes.decode('utf-8')
        return encoded_string
    except Exception as e:
        return f"Error encoding to Base64: {str(e)}"

if __name__ == "__main__":
    input_string = input("Enter the string to encode: ")
    encoded_result = encode_to_base64(input_string)
    print("Encoded result:", encoded_result)

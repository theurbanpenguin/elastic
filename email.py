import requests
import json
import re

def is_valid_email(email):
    # Simple regex for validating an email address
    regex = r'^\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
    if re.match(regex, email):
        return True
    else:
        return False

def send_to_logstash(message):
    logstash_url = 'http://localhost:5044'  # Logstash HTTP input endpoint

    headers = {'Content-Type': 'application/json'}
    response = requests.post(logstash_url, data=json.dumps(message), headers=headers)

    # Print response status for debugging
    print(f'Status code: {response.status_code}')
    print(f'Response text: {response.text}')

def main():
    email = input("Enter your email address: ")
    if is_valid_email(email):
        message = {
            'timestamp': '2023-06-23T12:00:00Z',
            'level': 'INFO',
            'message': 'Valid email provided',
            'email': email
        }
        send_to_logstash(message)
        print("Email is valid and has been sent to Logstash.")
    else:
        print("Invalid email address. Please try again.")

if __name__ == "__main__":
    main()
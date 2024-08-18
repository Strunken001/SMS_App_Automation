import os
from robot.api.deco import keyword
from robot.parsing.model import Keyword


def read_properties(properties_file):
    properties = {}
    with open(properties_file, 'r') as file:
        for line in file:
            if '=' in line:
                key, value = line.strip().split('=', 1)
                properties[key.strip()] = value.strip()
    return properties


# Example usage
@keyword("Load Properies")
def load_properties():
    current_directory = os.getcwd()
    relative_path = 'resources/smsconfig.properties'
    properties_file = os.path.join(current_directory, relative_path)  # Path to your properties file
    properties = read_properties(properties_file)

    # Accessing values from the properties file
    try:
        sender_id = properties['sender_id']
        contact_number = properties['contact_number']
        message = properties['message']
        auto_add_country_code = properties.get('auto_add_country_code', 'false').lower() == 'true'
        remove_duplicate = properties.get('remove_duplicate', 'false').lower() == 'true'

        # Print values for debugging
        print(f"Sender ID: {sender_id}")
        print(f"Contact Number: {contact_number}")
        print(f"Message: {message}")
        print(f"Auto Add Country Code: {auto_add_country_code}")
        print(f"Remove Duplicate: {remove_duplicate}")

    except KeyError as e:
        print(f"Error: Key not found in properties: {e}")

    return properties
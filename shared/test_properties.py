from robot.api.deco import keyword
from PropertiesLibrary import PropertiesManager
import os

class TestProperties:
    def __init__(self):
        self.properties = {}
# Create an instance of PropertiesManager
current_directory = os.getcwd()
relative_path = 'resources/smsconfig.properties'
properties_file = os.path.join(current_directory, relative_path)
manager = PropertiesManager(properties_file)

# Retrieve properties
sender_id = manager.get_key('sender_id')
contact_number = manager.get_key('contact_number')

@keyword("Get Desired Property")
def get_desired_property(key):
    global manager
    return manager.get_key(key)


# Print retrieved values
print(f"Sender ID: {sender_id}")
print(f"Contact Number: {contact_number}")

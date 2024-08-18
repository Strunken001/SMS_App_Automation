from robot.api.deco import keyword
class PropertiesLibrary:
    def __init__(self):
        self.properties = {}


    @keyword("Load Properties")
    def load_properties(self, properties_file):
        with open(properties_file, 'r') as file:
            for line in file:
                line = line.strip()
                if '=' in line:
                    key, value = line.split('=', 1)
                    self.properties[key.strip()] = value.strip()

    @keyword("Get Key")
    def get_key(self, key):
        return self.properties.get(key)

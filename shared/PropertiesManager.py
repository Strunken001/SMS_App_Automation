class PropertiesManager:
    def __init__(self, properties_file):
        self.properties = {}
        self._load_properties(properties_file)

    def _load_properties(self, properties_file):
        with open(properties_file, 'r') as file:
            for line in file:
                line = line.strip()
                if '=' in line:
                    key, value = line.split('=', 1)
                    self.properties[key.strip()] = value.strip()


    def get_property(self, key):
        return self.properties.get(key)
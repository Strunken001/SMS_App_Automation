import csv
import os
from pathlib import Path
from robot.api.deco import keyword

class CredentialsReader:
    def __init__(self):
        self.credentials = []
        self.index = 0
        #self.load_credentials()

    @keyword("Load Credentials")
    def load_credentials(self):
        # Construct the full path to the CSV file

        file_path = Path(os.getcwd() + r'/shared/resources/credentials.csv')

        # Read the CSV file and load the credentials into the list
        with open(file_path, mode='r', newline='', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            self.credentials = [row for row in reader]

    @keyword("Get Next Credential")
    def get_next_credential(self):
        # Get the next credential in the list
        if not self.credentials:
            raise ValueError("No credentials found")

        if self.index >= len(self.credentials):
            self.index = 0  # Reset to the beginning if we've reached the end

        credential = self.credentials[self.index]
        self.index += 1
        return credential


# Example usage (You can remove this part when using it in Robot Framework)
# if __name__ == "__main__":
#     #print( os.getcwd())
#     reader = CredentialsReader()
#     print(reader.get_next_credential())

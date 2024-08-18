import os

file_path = '../shared/resources/credentials.csv'

if os.path.isfile(file_path):
    print("File exists")
else:
    print("File does not exist")

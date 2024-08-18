import pandas as pd
from robot.api.deco import keyword


class CustomKeywordsLibrary:

    @keyword
    def read_csv_file(self,file_path):
        df = pd.read_csv(file_path)
        return df.to_dict(orient='records')

    @keyword
    def get_random_credential(self, credentials_list):
        import random
        return random.choice(credentials_list)

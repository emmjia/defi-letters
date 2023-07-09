#run to install all necessary packages
!pip install python-docx
import docx
import openpyxl
import pandas as pd
import numpy as np
import csv
import locale
import os
from datetime import datetime
from docx import Document
from docx.shared import Inches
from docx.shared import Pt
locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')  # Replace 'en_US.UTF-8' with your desired locale
workbook = openpyxl.Workbook()
worksheet = workbook.active

##Pre Defi Letters Requirement
#Creates required folder for new documents to be saved
folder_name = 'updated'
os.makedirs(folder_name, exist_ok=True)

#copies directory of Defi Letters python file
!cp /content/drive/MyDrive/Colab\ Notebooks/DefiLettersii.ipynb /content
!cp /content/drive/MyDrive/Colab\ Notebooks/buybacks.ipynb /content

"""##**Defi Letters**"""


# Copy and paste mid seven digit account numbers that you want to automatically update the Defi Letters.
#Make sure to have "data_combined.csv" and "defi_letter.docx"
data_combined = "/content/data_combined.csv"
list = [
1582254,
1615341,
1619284]

while True:
  for file_name in list:
     %run DefiLettersii.ipynb
  break

"""##**Buybacks**"""

# Commented out IPython magic to ensure Python compatibility.
c_df = pd.read_csv('/content/bb.csv', header = None).fillna(0)
c_df1 = pd.read_csv('/content/balances.csv', header = None).fillna(0)

accounts_amounts = {}

accounts = [
17329550002,
17372570003,
17379590002
]

amounts = [
 21094.01,
 7100.00,
 13002.65
]

for i in range(len(accounts)):
    accounts_amounts[accounts[i]] = amounts[i]

directory = accounts_amounts.keys()
total_collected = accounts_amounts.values()

matrix = np.empty((0,25))

while True:
  for directory, total_collected in accounts_amounts.items():
     %run buybacks.ipynb
    data_row = [directory, total_collected, '', balance, cust_pmts, total_collected, round(disi, 2), bbwvP, bbwvI, ddis, adis, wpay, ugap, uwar, drsv, late, NSF, repo, '', impo, '', gpsr, '', keys, lfe]

    new_row = np.array(data_row)
    matrix = np.vstack([matrix, new_row])

  df = pd.DataFrame(matrix)
  df.to_excel('buyback_output.xlsx', index = False)
  break

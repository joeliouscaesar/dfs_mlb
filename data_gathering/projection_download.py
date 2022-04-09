# file to download projections from:
# https://www.dailyfantasyfuel.com/mlb/projections/

import pandas as pd
import time 
import os
import shutil
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select

# download chromedriver: https://chromedriver.chromium.org/downloads
chromedriverpath = "./chromedriver/chromedriver.exe"

# method which downloads the projections
def download_projections(sleep_seconds = 5):
    
    # launches browser
    browser = webdriver.Chrome(chromedriverpath)
    
    # navigate to the website
    print("navigating...")
    projsite = "https://www.dailyfantasyfuel.com/mlb/projections/"
    browser.get(projsite)
    time.sleep(sleep_seconds)
    
    # download
    print("downloading...")
    download_button = browser.find_element_by_class_name('vertical-flex.hidden-xs.projections-download-container')
    download_button.click()
    time.sleep(sleep_seconds)
        
    # close browser
    browser.close()
    print("success!")
    return

download_projections(3)




